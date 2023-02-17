import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract, Signer } from 'ethers';

describe("BasicDutchAuction", function () {
    let owner: Signer;
    let bidder1: Signer;
    let bidder2: Signer;
    let dutchAuction: Contract;

  beforeEach(async function deployBasicDutchAuctionFixture() {
    [owner, bidder1, bidder2] = await ethers.getSigners();

    const basicDutchAuctionFactory = await ethers.getContractFactory("DutchAuction");
    dutchAuction = await basicDutchAuctionFactory.deploy(ethers.utils.parseEther('1'), owner.getAddress(), 10, ethers.utils.parseEther('0.1'));
    await dutchAuction.deployed();
  });

  describe("Deployment", function () {
    it('should allow a bid greater than or equal to the current price', async function () {
        const bidPrice = ethers.utils.parseEther('2')
        const winnerAddress = await dutchAuction.connect(bidder1).bid({ value: bidPrice })
        expect(winnerAddress.from.toLowerCase()).to.equal((await bidder1.getAddress()).toLowerCase())
      });
  });
});
