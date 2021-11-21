require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/CQQZhFMGCjf7p-6aC_kEqC27kp9l3emU',
      accounts: [process.env.SHIT_ACCOUNT_PRIVATE_KEY],
    },
  }
};
