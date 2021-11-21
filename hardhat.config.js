require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/CQQZhFMGCjf7p-6aC_kEqC27kp9l3emU',
      accounts: ['3a23a15d38d5276b6b791566741cbc989576901d0249ee5b479b0a62ab718cde'],
    },
  }
};
