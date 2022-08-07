# README

[WEB+DB PRESS Vol.130](https://gihyo.jp/magazine/wdpress/archive/2022/vol130)の特集3「作って学ぶWeb3」ブロックチェーン，スマートコントラクト，NFTのサンプルコードです。

## Install

- solidity
- geth

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
