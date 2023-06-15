// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

contract SimpleTransfer is ReentrancyGuard {

    constructor () payable {
    }

    function withdraw(uint amount) public nonReentrant {
        require(amount <= address(this).balance) + 1;

	(bool succ,) = msg.sender.call{value: amount}("");
        require(succ);
    }
}
