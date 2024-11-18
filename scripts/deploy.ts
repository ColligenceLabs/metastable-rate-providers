/*
 * npx hardhat run --network < baobab | cypress > scripts/deploy.ts
 */

import { ethers, upgrades, network } from 'hardhat';

function sleep(ms: number) {
  return new Promise((r) => setTimeout(r, ms));
}

async function main() {
  //
  const wKoKaia =
    network.config.chainId === 1001
      ? '0xE019c5f1dDAF64A30d7d0B036b746aCbD4Aa8Af8'
      : '0xdEC2Cc84f0a37Ef917f63212FE8ba7494b0E4B15';

  const wStKlay =
    network.config.chainId === 1001
      ? '0x524dcff07bff606225a4fa76afa55d705b052004'
      : '0x031fB2854029885E1D46b394c8B7881c8ec6AD63';

  const wGcKaia =
    network.config.chainId === 1001
      ? '0x4ec04f4d46d7e34ebf0c3932b65068168fdce7f6'
      : '0xa9999999c3D05Fb75cE7230e0D22F5625527d583';

  const SKlay =
    network.config.chainId === 1001
      ? '0xC04f81b4F06f692f7D1EE90faD0527Cca0E62eaD'
      : '0x77777779eE2d933dA027Ee1fB3590c41529046c8';

  const StKaia =
    network.config.chainId === 1001
      ? '0x4ca24B2Dee93CBdE1Bbf7f09fcc2650E4C2f5B3F'
      : '0x42952B873ed6f7f0A7E4992E2a9818E3A9001995';

  const owner = await ethers.getSigner(<string>network.config.from);
  console.log('>> Deploy owner : ', owner.address);

  // WKoKaia - Kommune
  const rateProvider1 = await ethers.getContractFactory('KoKaiaRateProvider');
  const RateProvider1 = await upgrades.deployProxy(rateProvider1, [wKoKaia], {
    initializer: 'initialize',
  });
  await RateProvider1.deployed();
  console.log('KoKaiaRateProvider deployed (KoKAIA) : ', RateProvider1.address);

  await sleep(2000);

  // WStKlay - stake.ly
  const rateProvider2 = await ethers.getContractFactory('KoKaiaRateProvider');
  const RateProvider2 = await upgrades.deployProxy(rateProvider2, [wStKlay], {
    initializer: 'initialize',
  });
  await RateProvider2.deployed();
  console.log('KoKaiaRateProvider deployed (stKLAY) : ', RateProvider2.address);

  await sleep(2000);

  // WGcKaia - SwapScanner
  const rateProvider3 = await ethers.getContractFactory('GcKaiaRateProvider');
  const RateProvider3 = await upgrades.deployProxy(rateProvider3, [wGcKaia], {
    initializer: 'initialize',
  });
  await RateProvider3.deployed();
  console.log('GcKaiaRateProvider deployed (GCKAIA) : ', RateProvider3.address);

  await sleep(2000);

  // stKAIA - Lair Bughole
  const rateProvider4 = await ethers.getContractFactory('StKaiaRateProvider');
  const RateProvider4 = await upgrades.deployProxy(rateProvider4, [StKaia], {
    initializer: 'initialize',
  });
  await RateProvider4.deployed();
  console.log('LstStaticRateProvider deployed (stKAIA) : ', RateProvider4.address);

  await sleep(2000);

  // sKLAY - Ozys
  const rateProvider5 = await ethers.getContractFactory('SKlayRateProvider');
  const RateProvider5 = await upgrades.deployProxy(rateProvider5, [SKlay], {
    initializer: 'initialize',
  });
  await RateProvider5.deployed();
  console.log('LstStaticRateProvider deployed (sKLAY): ', RateProvider5.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
