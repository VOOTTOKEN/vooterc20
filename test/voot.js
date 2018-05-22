const Voot = artifacts.require('./voot.sol');
const Utils = require('./helpers/Utils');
const BigNumber = require('bignumber.js');

let founderAddress;

const name = 'VOOT';
const symbol = 'voot';
const decimals = 18;
const alloc = 1000000;
let token;

contract('voot', (accounts) => {
    
    before(async() => {
        founderAddress = accounts[0];
        token = await Voot.new(name, symbol, decimals, founderAddress);
    });

    it('verify parameters', async() => {
        let founderAllocation = await token
            .balanceOf
            .call(founderAddress);
        assert.strictEqual(founderAllocation.dividedBy(new BigNumber(10).pow(18)).toNumber(), alloc);
    });

    it('verify the allocation variables', async() => {
        let _totalSupply = await token
            .totalSupply
            .call();
        assert.strictEqual(_totalSupply.dividedBy(new BigNumber(10).pow(18)).toNumber(), alloc);
        let _founderAddress = await token
            .founderAddress
            .call();
        assert.strictEqual(_founderAddress, founderAddress);
    });
        
});