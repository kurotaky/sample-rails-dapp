class GreetingsController < ApplicationController
  def index
    url = ENV.fetch('GETH_URL', 'http://localhost:8545')
    client = Eth::Client.create url
    contract = Eth::Contract.from_file(file: 'contracts/Greeter.sol')

    client.deploy_and_wait(contract)
    client.transact_and_wait(contract, "setName", "web3")

    @result = client.call(contract, "hello")
  end
end
