pragma solidity >= 0.4.11;
contract NameRegistry {

	// 컨트랙트를 나타낼 구조체
	struct Contract {
		address owner;
		address addr;
		string description;
	}

	// 등록된 레코드 수
	uint public numContracts;

	// 컨트랙트를 저장할 매핑
	mapping (string  => Contract) public contracts;

	// 생성자
	constructor() {
		numContracts = 0;
	}

	// 컨트랙트 등록
	function register(string memory _name) public returns (bool){
		// 아직 사용 되지 않은 이름이면 신규 등록
		if (contracts[_name].owner == address(0)) { // 0 -> address(0)
			Contract storage con = contracts[_name];
			con.owner = msg.sender;
			numContracts++;
			return true;
		} else {
			return false;
		}
	}


	function unregister(string memory _name) public returns (bool) {
		if (contracts[_name].owner == msg.sender) {
			contracts[_name].owner = address(0);	// 0 -> address(0) 
 			numContracts--;
 			return true;
		} else {
			return false;
		}
	}
	

	function changeOwner(string memory _name, address _newOwner) public onlyOwner(_name) {
		contracts[_name].owner = _newOwner;
	}
	

	function getOwner(string memory _name) view public returns (address) {
		return contracts[_name].owner;
	}
    

	function setAddr(string memory _name, address _addr) public onlyOwner(_name) {
		contracts[_name].addr = _addr;
    }
    

	function getAddr(string memory _name) view public returns (address) {
		return contracts[_name].addr;
	}
        

	function setDescription(string memory _name, string memory _description) public onlyOwner(_name) {
		contracts[_name].description = _description;
	}

	// 컨트랙트 설명 확인
	function getDescription(string memory _name) view public returns (string memory)  {
		return contracts[_name].description;
	}
    
	// 함수를 호출 전, 먼저 처리되는 modifier를 정의
	modifier onlyOwner(string memory _name) {
	    require(contracts[_name].owner == msg.sender);
		_;
	}
}
