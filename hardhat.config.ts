import { HardhatUserConfig } from 'hardhat/config';

// import '@nomiclabs/hardhat-ethers';
// import '@nomiclabs/hardhat-waffle';

import '@nomicfoundation/hardhat-toolbox';
import '@openzeppelin/hardhat-upgrades';
require('dotenv').config();

const { RPC_API_KEY, PRIV_KEY, ETHERSCAN_API_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.11',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    baobab: {
      chainId: 1001,
      url: 'https://public-en-kairos.node.kaia.io',
      accounts: [PRIV_KEY],
    },
    cypress: {
      chainId: 8217,
      url: 'https://public-en.node.kaia.io',
      // url: "https://klaytn-en.kommunedao.xyz:8651",
      accounts: [PRIV_KEY],
    },
  },
};

export default config;
