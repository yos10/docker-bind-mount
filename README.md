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
