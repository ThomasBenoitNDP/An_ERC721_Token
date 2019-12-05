pragma solidity  ^0.5.0 ;

contract SomeRegister {
   address backendContract;
   address[] previousBackends;
   address owner;

   constructor () public {
       owner = msg.sender;

   }  
   modifier onlyOwner() {
       require(msg.sender == owner, "no");
       _;
      }

   function changeBackend(address newBackend) public   onlyOwner()   returns (bool)   {
       if(newBackend != backendContract) {
           previousBackends.push(backendContract);
           backendContract = newBackend;
           return true;
       }       
	return false;   
	} 

}
