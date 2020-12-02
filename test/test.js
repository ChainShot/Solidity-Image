const { assert } = require("chai");

describe("Simple", function() {
  it("should get the variable `a`", async function() {
    const Simple = await ethers.getContractFactory("Simple");
    simple = await Simple.deploy();
    await simple.deployed();

    const a = await simple.a();
    assert.equal(a, 5);
  });
});
