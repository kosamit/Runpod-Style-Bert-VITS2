# Runpod-Style-Bert-VITS2

月読ちゃんモデルをrunpodのserverlessでアップするためにdocker imageを作成する。

## Usage
自分のdocker hubのUSERNAMEに変える。
これでビルドする。

```
docker build --progress=plain . -f Dockerfile -t <USERNAME>/runpod-style-bert-vits2-api:1.0.0
```

Docker Hubにログイン。

```
docker login
```

Docker Hubにプッシュする。

```
docker push <USERNAME>/runpod-style-bert-vits2-api:1.0.0
```
