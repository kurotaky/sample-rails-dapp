namespace :contract do
  desc "サンプルのコントラクトをローカルブロックチェーンネットワークにデプロイする"
  task deploy_sample_nft: :environment do
    url = ENV.fetch('GETH_URL', 'http://localhost:8545')
    client = Eth::Client.create url
    file = "contracts/SampleERC721.sol"
    contract = Eth::Contract.from_file(file:)
    address = client.deploy_and_wait(contract)
    client.transact_and_wait(contract, "setBaseURI", "https://kurotaky.github.io/nfts/metadata/")

    File.write("contracts/sample_erc721.json", {name: "SampleERC721", address:, file:}.to_json)
    puts "success!"
  end
end
