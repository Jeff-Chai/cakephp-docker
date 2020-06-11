# CakePHP Docker Environment

##### English introduction, please click：[here](./README.md)

這是為了搭配 CakePHP 4 而建置的一個 Docker 環境。

## 使用說明

### 決定你的專案名稱

你可以從`.env.example`複製出一個新的`.env`
這個`.env`會是這裡正式使用的環境設定。
其中請注意裡面`.env`中下述的部分：
```shell
APPLICATION=__APP_NAME__
```
`__APP_NAME__`會是你的專案名稱，同時也會是 database 的名稱，請務必更改它。

### 執行 `./run.sh`

這隻 shell 裡面含有 docker 的一些基本指令
離開的話只要輸入`exit`就可以了。

### 建立 docker image

輸入 `b`命令
它會執行 docker-compose build 
建立環境需要的 docker image。

### 啟動環境

輸入 `s` 命令
這個命令會在啟動完 docker container 後執行檢視命令
可以看到 docker container 啟動狀態。
