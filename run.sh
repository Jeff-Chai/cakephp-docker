#!/usr/bin/env bash
# BASEDIR=$(dirname "$0")
# cd "$BASEDIR"
# clear

printMenu() {
    echo "Docker Training Project"

    printPartition
}

printPartition() {
    cols=""
    # 取得畫面寬
    local windowsWidth=$(tput cols)
    for((j=1; j<=${windowsWidth}; j++ ))
    do
        cols=${cols}-
    done
    echo  -e "\033[0;32m${cols}\033[0m"
}

printCommands() {
    echo ""
    echo "b : 建立"
    echo "u : 啟動"
    echo "a : 檢視"
    echo "s : 啟動 & 檢視"
    echo "i : 進入 Container"
    echo "re: 全部重啟"
    echo "c : 全部停止"
    echo "r : 全部刪除"
    echo "q : 全部停止 & 刪除"
    # echo "q : 離開"
    # echo "* : 輸入任意指令"
    echo ""
}

exitProcess() {
    clear
    # 離開程序
    exit
}

printMenu
printf "\E[0;32m"
read -p "請按Enter開始Docker... " admin
printf "\E[0m"
clear

while :
do
    printCommands

    read -p "Please input: " input 

    case ${input} in
        b)
            echo "正在建立 Docker Image ... "
            echo ""
            docker-compose build
            echo "建立完成 ..."
            continue
            ;;
        u)
            echo "正在啟動 Docker Container ... "
            echo ""
            docker-compose up -d
            echo "啟動完成 ..."
            continue
            ;;
        a)
            echo "檢視 Docker Container 狀態"
            echo ""
            docker ps -a
            continue
            ;;
        s)
            echo "正在建立 Docker Container ... "
            echo ""
            docker-compose up -d
            echo "建立完成 ..."
            echo ""
            echo "檢視 Docker Container 狀態"
            echo ""
            docker ps -a
            continue
            ;;
        i)
            # 查看目前的 container
            docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.ID}}"
            echo  -e "\033[37;41m請輸入 Container Name(ex: apache)\033[0m"
            read -p "Name:" containerName
            clear
            #  進入 container
            if [[ ${containerName} ]]; then
                docker exec -it ${containerName} bash
            fi
            clear
            ;;
        re)
            echo "正在重啟全部 Docker Container ... "
            docker restart $(docker ps -q)
            echo "重啟完成 Docker Container ... "
            read -p "請按任意鍵繼續 ..."
            clear
            ;;
        c)
            echo "正在停止全部 Docker Container ... "
            docker stop $(docker ps -a -q)
            echo "停止完成 Docker Container ... "
            read -p "請按任意鍵繼續 ..."
            clear
            ;;
        r)
            echo "正在刪除全部 Docker Container ... "
            docker rm $(docker ps -a -q)
            echo "刪除完成 Docker Container ... "
            read -p "請按任意鍵繼續 ..."
            clear
            ;;
        q)
            echo "開始關閉全部 Docker Container ... "
            docker-compose down
            read -p "請按任意鍵繼續 ... "
            clear
            ;;
        exit)
            exitProcess
            ;;
        *)
            echo ""
            echo | ${input}
            # clear
            continue
            ;;
    esac
done