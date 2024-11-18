/*
 * npx hardhat run --network < baobab | cypress > scripts/upgrade.ts
 */

import { ethers, upgrades, network } from 'hardhat';

async function main() {
  const SKlay =
    network.config.chainId === 1001
      ? '0xC04f81b4F06f692f7D1EE90faD0527Cca0E62eaD'
      : '0x77777779eE2d933dA027Ee1fB3590c41529046c8';

  const proxy =
    network.config.chainId === 1001
      ? '0x36463693030241938225A59b976d285bAE555e65'
      : '0x15F6f25fDedf002B02d6E6be410451866Ff5Ac93'; // SKlay RateProvider

  const owner = await ethers.getSigner(<string>network.config.from);
  console.log('>> Deploy owner : ', owner.address);
  console.log(await upgrades.erc1967.getAdminAddress(proxy), 'Proxy Admin');

  const newImplementation = await ethers.getContractFactory('SKlayRateProvider');

  console.log('Upgrading SKLAY...');

  const sKlay = await upgrades.upgradeProxy(proxy, newImplementation);
  // const sKlay = await upgrades.upgradeProxy(proxy, newImplementation, {
  //   call: {
  //     fn: 'setSKlay',
  //     args: [SKlay],
  //   },
  // });

  console.log('SKLAY RateProvider upgraded : ', sKlay.address);
  console.log(await upgrades.erc1967.getAdminAddress(sKlay.address), 'Proxy Admin');
}

main();
