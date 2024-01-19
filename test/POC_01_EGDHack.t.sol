pragma solidity ^0.8.17;

import "forge-std/Test.sol";

interface IEGD_Finance {
    function calculateAll(address addr) external view returns (uint);
}

contract EGDAttacker is Test {
    
}