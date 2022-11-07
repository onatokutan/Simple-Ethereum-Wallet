pragma solidity ^0.8.13;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}
    fallback() external payable {}


    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    function send(address payable sendAddress) public payable {
        (bool sent, bytes memory data) = sendAddress.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
    function getWalletId() external view returns (address) {
        return address(this);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}