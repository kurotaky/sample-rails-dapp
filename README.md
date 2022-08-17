# README

[WEB+DB PRESS Vol.130](https://gihyo.jp/magazine/wdpress/archive/2022/vol130)の特集3「作って学ぶWeb3」ブロックチェーン，スマートコントラクト，NFTのサンプルコードです。

3章のサンプルコードについては[こちら](https://github.com/kurotaky/sample-rails-dapp/tree/add_contract/contracts)にあります。

## Install

- [Solidity](https://docs.soliditylang.org/en/v0.8.16/installing-solidity.html)
- [Geth](https://geth.ethereum.org/docs/install-and-build/installing-geth)

をインストールします。

## Rails Appとgethを起動

### Rails serverを起動

```bash
bin/dev
```

### geth起動

```bash
geth --dev --http
```

http://localhost:3000/ にアクセス


## Dockerで起動する

```bash
docker compose build
docker compose up
```

http://localhost:3000/ にアクセス
