contract SomeRegister {
   address backendContract;
   address[] previousBackends;
   address owner;

   function SomeRegister() {
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
