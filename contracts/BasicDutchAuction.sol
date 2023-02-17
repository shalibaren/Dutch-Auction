//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract DutchAuction {

    // DutchAuction function
    uint256 reservePrice;
    address judgeAddress;
    uint256 numOpenBlocks;
    uint256 priceDecrement;
    address owner;
    uint256 initPrice;
    uint256 startBlock;

    // bid function
    uint256 public currentPrice;
    bool auctionEnd;
    address winnerAddress;
    uint256 winningBid;

    constructor(uint256 _reservePrice, address _judgeAddress, uint256 _numBlocksAuctionOpen, uint256 _offerPriceDecrement) {
        reservePrice = _reservePrice;
        judgeAddress = _judgeAddress;
        numOpenBlocks = _numBlocksAuctionOpen;
        priceDecrement = _offerPriceDecrement;
        owner = msg.sender;
        startBlock = block.number;
        initPrice = _reservePrice + _numBlocksAuctionOpen * _offerPriceDecrement;
    }

    function bid() public payable returns (address) {
        currentPrice = initPrice - priceDecrement * (block.number - startBlock);
        // console.log(initPrice, priceDecrement, block.number, startBlock);
        // console.log(currentPrice, msg.value);
        // console.log(msg.sender);
        require(
            auctionEnd != true,
            "The auction has already ended"
        );

        require(
            msg.value >= currentPrice,
            "Not Accepted! The bid price is lower than the current price."
        );

        auctionEnd = true;
        winnerAddress = msg.sender;

        return msg.sender;
    }

    // //for testing framework
    // function nop() public pure returns(bool) {
    //     return true;
    // }
}