async function main() {
  const fs = require("fs");
  const factory = await ethers.getContractFactory("TestNFT");
  const contract = await factory.deploy();
  console.log("Deployed to:", contract.address);
  await contract.mint();
  const svg = await contract.getSVG();    
  fs.writeFileSync("test.svg", svg);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });