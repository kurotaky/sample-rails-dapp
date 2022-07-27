class GreetingsController < ApplicationController
  def index
    client = Eth::Client.create "http://localhost:8545"
    contract = Eth::Contract.from_file(file: 'contracts/Greet.sol')

    client.deploy_and_wait(contract)
    client.transact_and_wait(contract, "setName", "web3")

    @result = client.call(contract, "hello")
  end
end
