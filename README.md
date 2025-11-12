https://zenn.dev/bitkey_dev/articles/7802c25e79e1db

https://github.com/hosht/zenn-articles/blob/main/articles/7802c25e79e1db.md

Zennの記事の参照実装です

## docker build

```shell
docker build -t hosht/node-docker-example-for-zenn-article:latest .
```

## docker run

```shell
docker run --rm --name express -it -p 8080:8080 -e PORT=8080 hosht/node-docker-example-for-zenn-article:latest
```
