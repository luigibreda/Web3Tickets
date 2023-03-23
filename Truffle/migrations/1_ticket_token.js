const TicketToken = artifacts.require("TicketToken");

module.exports = async function (deployer, _network, accounts) {
    await deployer.deploy(TicketToken);
}