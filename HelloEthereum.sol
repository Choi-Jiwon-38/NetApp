pragma solidity ^0.4.11;
contract HelloEthereum {
	// �ּ� �ֱ� 1
	string public msg1;	
	
	string private msg2; // �ּ� �ֱ� 2
	
	/* �ּ� �ֱ� 3 */
	address public owner;
	
	uint8 public counter;
	
	/// ������
	function HelloEthereum(string _msg1) {
		// msg1�� _msg1�� ���� ����
		msg1 = _msg1;
		
		// owner�� ���� �� ��Ʈ��Ʈ�� ������ ���� �ּҸ� ����
		owner = msg.sender;
		
		// counter�� 0���� �ʱ�ȭ
		counter = 0;
	}
	
	/// msg2 ������ �޼���
	function setMsg2(string _msg2) public {
		// if�� ��� ��
		if(owner != msg.sender) {
			throw;
		} else {
			msg2 = _msg2;	
		}
	}
	
	// msg2�� ������ �޼���
	function getMsg2() constant public returns(string) {
		return msg2;
	}
	
	function setCounter() public {
		// for�� ��� ��
		for(uint8 i = 0; i < 3; i++) {
			counter++;
		}
	}
}
