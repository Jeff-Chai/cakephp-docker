# CakePHP Docker Environment

##### English introduction, please click：[here](./README.md)

這是為了搭配 CakePHP 4 而建置的一個 Docker 環境。

## 使用說明

### CakePHP 環境建立

#### Docker 環境

```
https://github.com/Jeff-Chai/cakephp-docker
```

請將上述網址內的環境下載至本機後，進行以下操作：

- 從 `.env.example` 複製出一份新的 `.env`
- 將 `.env` 中的 __\_\_APP_NAME\_\___ 設定為專案名稱
- 若不存在 `project` 資料夾，請建立它

其中請注意裡面 `.env` 中下述的部分：
```shell
APPLICATION=__APP_NAME__
```
__\_\_APP_NAME\_\___ 會是你的專案名稱，同時也會是 database 的名稱，請務必更改它。

**Notice：** 在以下操作範例中，專案名稱將以 `cms` 為名稱進行

---

#### 取得 CakePHP

在 docker 根目錄下有個檔案，名為 `run.sh` 
用以簡化 docker-compare 指令操作

- 執行 `./run.sh`
- 輸入 `b` 命令，建立 docker image
- 輸入 `s` 命令，啟動 docker container
- 輸入 `i` 命令，進入 container ： __php__
- 執行下述指令：
    ```shell
    composer self-update && composer create-project --prefer-dist cakephp/app:4.* cms
    ```
- 進入 `cms` 資料夾
- 安裝 CakePHP 相關套件：
    ```shell
    composer install && composer update && composer dump-autoload --optimize
    ```
    中間如遇到 `Set Folder Permissions ? (Default to Y) [Y,n]?` 
    請輸入 `Y` ，這是用以在 CakePHP 中， `tmp` 的暫存資料夾

完成後到瀏覽器的網址列中輸入 `127.0.0.1` ，就能看見 CakePHP 預設的頁面了

---

#### CakePHP 參數設置

在瀏覽器看到的 CakePHP 預設首頁中，可以看到系統提示尚未完成的項目
大致會有兩個基本的系統問題需要處理：

- 設定 `config/.env`
- 設定 `config/app_local.php`
- 連結 mysql 資料庫

以下分別說明設置方法：

##### 設定 config/.env

- 進入 `cms/config` 資料夾
- 複製 `.env.example` 輸出成 `.env`
- 編輯 `.env`
    - APP_NAME="__\_\_APP_NAME\_\___" 改成 APP_NAME="`cms`"
    - SECURITY_SALT="__\_\_SALT\_\___" 改成 SECURITY_SALT="`{任意數字+小寫字母}`"

##### 設定 config/app_local.php

- 進入 `cms/config` 資料夾
- 複製 `.app_local.example.php` 輸出成 `.app_local.php`
- 找到 Security ，把 'salt' => env('SECURITY_SALT', '__\_\_SALT\_\___')
    改成 'salt' => env('SECURITY_SALT', '{與 .env 中 `SECURITY_SALT 相同的值`}')

##### 連結 mysql 資料庫

- 編輯 `app_local.php` ，找到 **Datasources** ，把下列內容參數改成 yaml 中對應的 mysql environment 設定：
    ```php
    'host' => '{your mysql host}',
    'username' => 'test',
    'password' => 'test',
    'database' => 'cms',
    ```
    **Notice：** **username**, **password**, **database** 的值來自 `docker/docker-compose.yml`

以上，就是 CakePHP 4 的基本安裝流程。

---

額外補充：

- CakePHP 官方文件，說明與範例： [連結](https://book.cakephp.org/4/en/tutorials-and-examples.html)
- Database 的 table 建立與命名規範： [連結](https://book.cakephp.org/4/en/intro/conventions.html#database-conventions)
