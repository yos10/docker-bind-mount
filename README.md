# Windows の Docker では共有フォルダのオーナーが root になるらしいので試してみた

## フォルダを共有しない場合

docker-compose.yml
```yml
version: '3'
services:
  app:
    build: .
    tty: true
    ports:
      - 8000:8000
    # volumes:
    #   - .:/home/node/app
```

```bash
docker-compose build --no-cache
docker-compose up -d
docker-compose exec app bash
```

```bash
cd ../
ls -l
```

結果

```
$ docker-compose exec app bash
node@578b31633ba7:~/app$ cd ../
node@578b31633ba7:~$ ls -l
total 4
drwxr-xr-x 2 node node 4096  9月  4 14:52 app
node@578b31633ba7:~$
```

## フォルダを共有する場合

docker-compose.yml
```yml
version: '3'
services:
  app:
    build: .
    tty: true
    ports:
      - 8000:8000
    volumes:
      - .:/home/node/app
```

```bash
docker-compose build --no-cache
docker-compose up -d
docker-compose exec app bash
```

```bash
cd ../
ls -l
```

結果

```
$ docker-compose exec app bash
node@fbf4b6d71ddc:~/app$ cd ../
node@fbf4b6d71ddc:~$ ls -l
total 0
drwxrwxrwx 1 root root 4096  9月  4 21:37 app
node@fbf4b6d71ddc:~$
```

参考

https://github.com/docker-library/postgres/issues/558#issuecomment-472234418

https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user

---
1. Microsoft Store から Ubuntu 20.04 をインストール
2. Docker Desktop の Dashboard から WSL INTEGRATION で Ubuntu-20.04 にチェック
3. //wsl$/Ubuntu-20.04/home/USERNAME/workspace  
↑をワークスペースとして使っていくことで解決しそう。

Improve container performance  
https://code.visualstudio.com/remote/advancedcontainers/improve-performance#_store-your-source-code-in-the-wsl-2-filesystem-on-windows

Developing inside a Container using Visual Studio Code Remote Development  
https://code.visualstudio.com/docs/remote/containers#_open-a-wsl-2-folder-in-a-container-on-windows

Docker Desktop WSL 2 バックエンド | Docker ドキュメント  
https://matsuand.github.io/docs.docker.jp.onthefly/desktop/windows/wsl/#install
