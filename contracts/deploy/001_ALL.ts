// npx hardhat deploy --network mumbai --tags ALL
// npx hardhat deploy --network fantomtest --tags ALL
// npx hardhat deploy --network polygon --tags ALL
// npx hardhat deploy --network evmostest --tags ALL
// npx hardhat deploy --tags ALL
// yarn watch:deploytest
// forge build --watch

import { ethers } from "hardhat"
import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

import fs from "fs"

export async function mydeploy(hre: HardhatRuntimeEnvironment, contractName: string, from: string, args: any, log: boolean, gasLimit: number) {
  console.log("mydeploy: " + contractName + "\n")
  await ethers.getContractFactory(contractName)
  const ret = await hre.deployments.deploy(contractName, {
    from: from,
    args: args,
    log: log,
    gasLimit: gasLimit,
  })
  return await ethers.getContractAt(ret.abi, ret.address)
}

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  console.log("deployment..")
  console.log("hre.network.name = " + hre.network.name)
  const networkName = hre.network.name
  const signers = await ethers.getSigners()
  const deployer = signers[0].address
  const gasLimit = 8000000
  console.log("deployer = " + deployer)

  //////////////// FakeAUSDC
  const FakeAUSDC = await mydeploy(hre, "FakeAUSDC", deployer, [], true, gasLimit)
  console.log("#FakeAUSDC")
  console.log(
    "npx hardhat verify --network " +
      hre.network.name +
      " " +
      FakeAUSDC.address +
      " " +
      " --contract " +
      "src/FakeAUSDC.sol" +
      ":" +
      "FakeAUSDC" +
      " "
  )
  await (await FakeAUSDC.mint(deployer, "1000000000000000000000")).wait()

  //////////////// WikiVoting
  const WikiVoting = await mydeploy(hre, "WikiVoting", deployer, [], true, gasLimit)
  console.log("#WikiVoting")
  console.log(
    "npx hardhat verify --network " +
      hre.network.name +
      " " +
      WikiVoting.address +
      " " +
      " --contract " +
      "src/WikiVoting.sol" +
      ":" +
      "WikiVoting" +
      " "
  )

  //////////////// WikiFactory
  const WikiFactory = await mydeploy(hre, "WikiFactory", deployer, [FakeAUSDC.address, WikiVoting.address], true, gasLimit)
  console.log("#WikiFactory")
  console.log(
    "npx hardhat verify --network " +
      hre.network.name +
      " " +
      WikiFactory.address +
      " " +
      FakeAUSDC.address +
      " " +
      WikiVoting.address +
      " " +
      " --contract " +
      "src/WikiFactory.sol" +
      ":" +
      "WikiFactory" +
      " "
  )
}

func.tags = ["ALL"]

func.skip = async (hre) => {
  return (
    hre.network.name !== "hardhat" &&
    hre.network.name !== "astar" &&
    hre.network.name !== "shiden" &&
    hre.network.name !== "fantomtest" &&
    hre.network.name !== "evmos" &&
    hre.network.name !== "evmostest" &&
    hre.network.name !== "localhost" &&
    hre.network.name !== "polygon" &&
    hre.network.name !== "mumbai" &&
    hre.network.name !== "bsctest" &&
    hre.network.name !== "fantom" &&
    hre.network.name !== "harmony" &&
    hre.network.name !== "harmonytest" &&
    hre.network.name !== "shibuya"
  )
}
export default func
