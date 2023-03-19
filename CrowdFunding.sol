pragma solidity ^0.4.11;
contract CrowdFunding {
	// ������ ����ü
	struct Investor {
		address addr;	// �������� ��巹��
		uint amount;	// ���ھ�
	}
	
	address public owner;		// ��Ʈ��Ʈ ������
	uint public numInvestors;	// ������ ��
	uint public deadline;		// ������ (UnixTime)
	string public status;		// ���Ȱ�� �������ͽ�
	bool public ended;			// ��� ���Ῡ��
	uint public goalAmount;		// ��ǥ��
	uint public totalAmount;	// �� ���ھ�
	mapping (uint => Investor) public investors;	// ������ ������ ���� ����
	
	modifier onlyOwner () {
		require(msg.sender == owner);
		_;
	}
	
	/// ������
	function CrowdFunding(uint _duration, uint _goalAmount) {
		owner = msg.sender;

		// ������ ���� (Unixtime)
		deadline = now + _duration;

		goalAmount = _goalAmount;
		status = "Funding";
		ended = false;

		numInvestors = 0;
		totalAmount = 0;
	}
	
	/// ���� �ÿ� ȣ��Ǵ� �Լ�
	function fund() payable {
		// ����� �����ٸ� ó�� �ߴ�
		require(!ended);
		
		Investor inv = investors[numInvestors++];
		inv.addr = msg.sender;
		inv.amount = msg.value;
		totalAmount += inv.amount;
	}
	
	/// ��ǥ�� �޼� ���� Ȯ��
	/// �׸��� ��� ����/���� ���ο� ���� �۱�
	function checkGoalReached () public onlyOwner {		
		// ����� �����ٸ� ó�� �ߴ�
		require(!ended);
		
		// ������ ������ �ʾҴٸ� ó�� �ߴ�
		require(now >= deadline);
		
		if(totalAmount >= goalAmount) {	// ��� ������ ���
			status = "Campaign Succeeded";
			ended = true;
			// ��Ʈ��Ʈ �����ڿ��� ��Ʈ��Ʈ�� �ִ� ��� �̴��� �۱�
			if(!owner.send(this.balance)) {
				throw;
			}
		} else {	// ��� ������ ���
			uint i = 0;
			status = "Campaign Failed";
			ended = true;
			
			// �� �����ڿ��� ���ڱ��� ������
			while(i <= numInvestors) {
				if(!investors[i].addr.send(investors[i].amount)) {
					throw;
				}
				i++;
			}
		}
	}
	
	/// ��Ʈ��Ʈ�� �Ҹ��Ű�� ���� �Լ�
	function kill() public onlyOwner {
		selfdestruct(owner);
	}
}
