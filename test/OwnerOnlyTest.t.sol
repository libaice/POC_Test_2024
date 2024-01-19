pragma solidity 0.8.10;

import "forge-std/Test.sol";

error Unauthorized();

contract OwnerOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }
}

contract OwnerOnlyTest is Test {
    OwnerOnly public ownerOnly;

    function setUp() public {
        ownerOnly = new OwnerOnly();
    }

    function test_IncrementAsOwner() public {
        assertEq(ownerOnly.count(), 0);
        ownerOnly.increment();
        assertEq(ownerOnly.count(), 1);
    }

    function test_RevertWhen_Caller_ISNotOwner() public{
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        ownerOnly.increment();
    }
}
