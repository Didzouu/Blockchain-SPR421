// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
 
contract Lottery {

    address public owner;

    address[] public players;
 
    constructor() {

        owner = msg.sender;

    }
 
    modifier OnlyOwner() {

        require(msg.sender == owner, "You are not the owner");

        _;

    }

    modifier OnlyPlayer() {

    bool isPlayer = false;
 
    for (uint i = 0; i < players.length; i++) {

        if (players[i] == msg.sender) {

            isPlayer = true;

            break;

        }

    }
 
    require(isPlayer, "You are not a player");

    _;

}
 
 
    function enter() external payable {

        require(msg.value == 2 ether, "Send exactly 2 ETH");

        players.push(msg.sender);

    }
 
    function getBalanceL() public view returns (uint256) {

        return address(this).balance;

    }
 
    function getPlayersCount() public view returns (uint) {

    return players.length;

    }
 
    function random() internal view returns (uint) {

        return uint(

            keccak256(

                abi.encodePacked(

                    block.timestamp,

                    block.difficulty,

                    players.length

                )

            )

        );

    }
 
    function pickwinner() external OnlyOwner{

        require(players.length >= 2, "Not enough players");
 
        uint index = random() % players.length;

        address winner = players[index];
 
        (bool sent, ) = payable(winner).call{value: address(this).balance}("");

        require(sent, "Failed to send Ether");

        delete players;

    }

    function amIPlayer() external view OnlyPlayer returns (bool) {

        return true;

    }

}
 