// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.4.11; // Compiler 버전 수정 (0.4.11 이상)
contract HelloEthereum {

	string public msg1;	
	
	string private msg2;
	
	address public owner;
	
	uint8 public counter;

	// HelloEthereum -> constructor 수정
	constructor (string memory _msg1) {
		msg1 = _msg1;
		
		owner = msg.sender;
		
		counter = 0;
	}
	
	function setMsg2(string memory _msg2) public {
		if(owner != msg.sender) {
			revert(); // throw -> revert 변경
		} else {
			msg2 = _msg2;	
		}
	}
	
	function getMsg2() view public returns(string memory) { // constant -> view
		return msg2;
	}
	
	function setCounter() public {
		for(uint8 i = 0; i < 3; i++) {
			counter++;
		}
	}
}
