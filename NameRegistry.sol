pragma solidity ^0.4.11;
contract NameRegistry {

	// ��Ʈ��Ʈ�� ��Ÿ�� ����ü
	struct Contract {
		address owner;
		address addr;
		bytes32 description;
	}

	// ��ϵ� ���ڵ� ��
	uint public numContracts;

	// ��Ʈ��Ʈ�� ������ ����
	mapping (bytes32  => Contract) public contracts;
    
	/// ������
	function NameRegistry() {
		numContracts = 0;
	}

	/// ��Ʈ��Ʈ ���
	function register(bytes32 _name) public returns (bool){
		// ���� ������ ���� �̸��̸� �ű� ���
		if (contracts[_name].owner == 0) {
			Contract con = contracts[_name];
			con.owner = msg.sender;
			numContracts++;
			return true;
		} else {
			return false;
		}
	}

	/// ��Ʈ��Ʈ ����
	function unregister(bytes32 _name) public returns (bool) {
		if (contracts[_name].owner == msg.sender) {
			contracts[_name].owner = 0;
 			numContracts--;
 			return true;
		} else {
			return false;
		}
	}
	
	/// ��Ʈ��Ʈ ������ ����
	function changeOwner(bytes32 _name, address _newOwner) public onlyOwner(_name) {
		contracts[_name].owner = _newOwner;
	}
	
	/// ��Ʈ��Ʈ ������ ���� Ȯ��
	function getOwner(bytes32 _name) constant public returns (address) {
		return contracts[_name].owner;
	}
    
	/// ��Ʈ��Ʈ ��巹�� ����
	function setAddr(bytes32 _name, address _addr) public onlyOwner(_name) {
		contracts[_name].addr = _addr;
    }
    
	/// ��Ʈ��Ʈ ��巹�� Ȯ��
	function getAddr(bytes32 _name) constant public returns (address) {
		return contracts[_name].addr;
	}
        
	/// ��Ʈ��Ʈ ���� ����
	function setDescription(bytes32 _name, bytes32 _description) public onlyOwner(_name) {
		contracts[_name].description = _description;
	}

	/// ��Ʈ��Ʈ ���� Ȯ��
	function getDescription(bytes32 _name) constant public returns (bytes32)  {
		return contracts[_name].description;
	}
    
	/// �Լ��� ȣ�� �� ���� ó���Ǵ� modifier�� ����
	modifier onlyOwner(bytes32 _name) {
	    require(contracts[_name].owner == msg.sender);
		_;
	}
}
