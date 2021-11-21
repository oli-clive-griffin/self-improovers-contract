const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('EpicNFT');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("deployed to address: ", nftContract.address);

  tx = await nftContract.makeEpicNFT();
  await tx.wait();

  console.log("first nft mined", tx);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
