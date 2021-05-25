const { assert } = require("chai");

const contracts = ['Simple6', 'Simple7', 'Simple8'];

contracts.forEach((name) => {
  describe(name, () => {
    it("should get the variable `a`", async function() {
      const Contract = await ethers.getContractFactory(name);
      contract = await Contract.deploy();
      await contract.deployed();

      const a = await contract.a();
      assert.equal(a, 5);
    });
  });
});
