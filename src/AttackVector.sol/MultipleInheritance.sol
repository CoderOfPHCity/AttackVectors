// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
 
contract adminChecker {
 
   address admin = msg.sender;
   function roleCheckk() internal view returns (bool) {
       return msg.sender == admin;
   }
}
 
contract guestChecker {
 
   address guest = msg.sender;
   function roleCheck() internal view returns (bool) {
       return msg.sender == guest;
   }
}
 
contract MultipleInheritance is adminChecker, guestChecker {
 
   function kill() external{
        require(roleCheck(), "Not an Admin");
    
   }
}
