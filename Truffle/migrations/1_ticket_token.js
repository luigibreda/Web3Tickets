const { walletsMainnet, walletsTestnet, walletsTestnetDev, devConfig } = require("../helpers/wallets");
const TicketToken = artifacts.require("TicketToken");

module.exports = async function (deployer, _network, accounts) {
    let wallets = {};

    if (_network === "development") {
        wallets._owner = accounts[0];
        _overwrite = true;
    } else if (_network === "testnet" && devConfig) {
        wallets = walletsTestnetDev;
        _overwrite = true;
    } else if (_network === "testnet" && !devConfig) {
        wallets = walletsTestnet;
        _overwrite = true;
    } else if (_network === "bsc") {
        wallets = walletsMainnet;
        _overwrite = true;
    }
    await deployer.deploy(TicketToken, wallets._owner);
}