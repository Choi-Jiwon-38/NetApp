pragma solidity ^0.4.11;
contract SmartSwitch {
	// ����ġ�� ����� ����ü
	struct Switch {
		address addr;	// �̿��� ��巹��
		uint	endTime;	// �̿� ���� �ð� (UnixTime)
		bool 	status;	// true�̸� �̿� ����
	}
	
	address public owner;	// ���� ������ ��巹��
	address public iot;	// IoT ��ġ�� ��巹��
		
	mapping (uint => Switch) public switches;	// Switch ����ü�� ���� ����
	uint public numPaid;			// ���� Ƚ��
	
	/// ���� ������ ���� üũ
	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}
	
	/// IoT ��ġ ���� üũ
	modifier onlyIoT() {
		require(msg.sender == iot);
		_;
	}
	
	/// ������
	/// IoT ��ġ�� ��巹���� ���ڷ� ����
	function SmartSwitch(address _iot) {
		owner = msg.sender;
		iot = _iot;
		numPaid = 0;
	}

	/// �̴��� ������ �� ȣ��Ǵ� �Լ�
	function payToSwitch() public payable {
		// 1 ETH�� �ƴϸ� ó�� ����
		require(msg.value == 1000000000000000000);
		
		// Switch ����
		Switch s = switches[numPaid++];
		s.addr = msg.sender;
		s.endTime = now + 300;
		s.status = true;
	}
	
	/// �������ͽ��� �����ϴ� �Լ�
	/// �̿� ���� �ð��� ȣ���
	/// ���ڴ� switches�� Ű ��
	function updateStatus(uint _index) public onlyIoT {
		// �ε��� ���� �ش��ϴ� Switch ����ü�� ������ ����
		require(switches[_index].addr != 0);
		
		// �̿� ���� �ð��� ���� �ʾ����� ����
		require(now > switches[_index].endTime);
		
		// �������ͽ� ����
		switches[_index].status = false;
	}

	/// ���ҵ� �̴��� �����ϴ� �Լ�
	function withdrawFunds() public onlyOwner {
		if (!owner.send(this.balance)) 
			throw;
	}
	
	/// ��Ʈ��Ʈ�� �Ҹ��Ű�� �Լ�
	function kill() public onlyOwner {
		selfdestruct(owner);
	}
}
