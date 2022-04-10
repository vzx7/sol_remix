// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
// Contract в сети Ropsten 0xc82420aa18f2d738e6dcab1d0299179c82a3e6d928116e9543bd6f8c2a661ef4

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20VZ is ERC20 {

    uint256 _transactionCount;
    mapping(uint => address) senders;

    constructor() ERC20("VZToken", "VZ20") {
        _mint(msg.sender, 100000);
    }

    function sendFunds(address _to, uint _amount) public payable {
        require(balanceOf(msg.sender) >= _amount, "!!! Transfer amount exceeds balance !!!");
        transfer(_to, _amount);
        _transactionCount += 1;
        senders[_transactionCount] = msg.sender;
    }

    function getTransctionCount() public view returns (uint) {
        return _transactionCount;
    }

    function getSenderByTransactionNum(uint _num) public view returns (address) {
        require(_transactionCount >= _num, "Your number exceeds the number of transactions on this contract, use the get method 'getTransctionCount()' to get the number of transactions....");
        return senders[_num];
    }
}

