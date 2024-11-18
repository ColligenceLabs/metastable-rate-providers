/*
 * npx hardhat run --network < baobab | cypress > scripts/upgrade-stkaia.ts
 */

import { ethers, upgrades, network } from 'hardhat';

async function main() {
  const StKaia =
    network.config.chainId === 1001
      ? '0x0000000000000000000000000000000000000000'
      : '0x42952B873ed6f7f0A7E4992E2a9818E3A9001995';

  const proxy =
    network.config.chainId === 1001
      ? '0x36463693030241938225A59b976d285bAE555e65'
      : '0xefBDe60d5402a570DF7CA0d26Ddfedc413260146'; // stKaia RateProvider

  const owner = await ethers.getSigner(<string>network.config.from);
  console.log('>> Deploy owner : ', owner.address);
  console.log(await upgrades.erc1967.getAdminAddress(proxy), 'Proxy Admin');

  const newImplementation = await ethers.getContractFactory('StKaiaRateProvider');

  console.log('Upgrading StKaia...');

  const stKaia = await upgrades.upgradeProxy(proxy, newImplementation);
  // const sKlay = await upgrades.upgradeProxy(proxy, newImplementation, {
  //   call: {
  //     fn: 'setStKaia',
  //     args: [StKaia],
  //   },
  // });

  console.log('StKaia RateProvider upgraded : ', stKaia.address);
  console.log(await upgrades.erc1967.getAdminAddress(stKaia.address), 'Proxy Admin');
}

main();
