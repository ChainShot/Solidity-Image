require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: {
    version: "0.7.5",
    settings: {
      optimizer: {
        enabled: false,
        runs: 0
      }
    }
  },
  mocha: {
    reporter: require("@codewars/mocha-reporter"),
  }
};
