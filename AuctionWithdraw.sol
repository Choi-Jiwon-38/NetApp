pragma solidity ^0.4.11;
contract AuctionWithdraw {
	address public highestBidder;	// �ְ� ������ ��巹��
	uint public highestBid;	// �ְ� ������
	mapping(address => uint) public userBalances;	// ��ȯ�� �׼��� �����ϴ� ����
	
	/// ������
	function AuctionWithdraw() payable {
		highestBidder = msg.sender;
		highestBid = 0;
	}
	
	/// ���� ó�� �Լ�
	function bid() public payable {
		// �������� ���� �ְ� �����׺��� ū�� Ȯ��
		require(msg.value > highestBid);

		// �ְ� ������ ��巹���� ���� ��ȯ�׼� ������Ʈ
		userBalances[highestBidder] += highestBid;
				
		// ������Ʈ ������Ʈ
		highestBid = msg.value;
		highestBidder = msg.sender;
	}
	
	function withdraw() public{
		// ��ȯ�� �׼��� 0���� ū�� Ȯ��
		require(userBalances[msg.sender] > 0);
		
		// ��ȯ�� �׼��� ����
		uint refundAmount = userBalances[msg.sender];
		
		// ��ȯ�� ������Ʈ
		userBalances[msg.sender] = 0;
		
		// ������ ��ȯ ó��
		if(!msg.sender.send(refundAmount)) {
			throw;
		}
	}
}
