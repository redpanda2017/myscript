## git 基本操作

## github 远程仓库
##### 从远程仓库克隆到本地
git clone git://github.com/redpanda2017/myscript

##### 列出远程服务器简写
git remote

(origin是从远程clone的仓库的默认名称)

##### 显示需要读写远程仓库使用的 Git 保存的简写与其对应的 URL
git remote -v

##### 添加一个新的远程 Git 仓库
git remote add <short-name> <url> 

##### 显示远程仓库
git remote show origin

##### 拉取远程的仓库中有但你没有的信息
git fetch remote-name

##### 将 master 分支推送到 origin 服务器
git push origin master

##### 远程仓库的移除与重命名
