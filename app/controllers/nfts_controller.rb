class NftsController < ApplicationController
  def create
    client.transact_and_wait(contract, "mint")
    redirect_to nfts_path, notice: "NFTを発行しました!"
  end

  def index
    @name = client.call(contract, "name")
    @symbol = client.call(contract, "symbol")

    all_nfts = JSON.parse client.call(contract, "allNfts")
    @nfts = []
    # サンプルで用意した画像は3つのみなので、0..2の範囲で表示します
    all_nfts[0..2].each do |nft|
      res = Net::HTTP.get(URI.parse(nft["token_uri"]))
      metadata = JSON.parse res
      @nfts << nft.merge(metadata)
    end
  end

  def show
    @contract_address = contract_address
    @token_id = params[:id].to_i
    @owner = client.call(contract, "ownerOf", @token_id)

    token_uri = client.call(contract, "tokenURI", @token_id)
    res = Net::HTTP.get(URI.parse(token_uri))
    @image = JSON.parse(res)["image"]
  end

  def new
  end

  private

  def client
    Eth::Client.create "http://localhost:8545"
  end

  def contract
    contract = Eth::Solidity.new.compile contract_file
    Eth::Contract.from_abi(name: contract_name, address: contract_address, abi: contract[contract_name]["abi"].to_json)
  end

  def contract_file
    contract_settings["file"]
  end

  def contract_name
    contract_settings["name"]
  end

  def contract_address
    contract_settings["address"]
  end

  def contract_settings
    JSON.parse(File.read Rails.root.join("contracts/sample_erc721.json"))
  end
end
