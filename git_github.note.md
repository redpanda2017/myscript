## git 基本操作

##### 1. 仓库初始化
mkdir workdir
cd workdir
git init

##### 2. 提交修改到暂存区
git add file  or  git add *

##### 3. 提交暂存区内容到分支上
git commit -m "增加..."

##### 4. 仓库状态
git status

##### 5. 仓库日志
git log

##### 6. 仓库的每一次操作
git reflog

##### 7. 

## github 远程仓库
##### 1. 从远程仓库克隆到本地

git clone git://github.com/redpanda2017/myscript

##### 2. 列出远程服务器简写

git remote

(origin是从远程clone的仓库的默认名称)

##### 3. 显示需要读写远程仓库使用的 Git 保存的简写与其对应的 URL

git remote -v

##### 4. 添加一个新的远程 Git 仓库

git remote add <short-name> <url> 

##### 5. 显示远程仓库

git remote show origin

##### 6. 拉取远程的仓库中有但你没有的信息

git fetch remote-name

##### 7. 将 master 分支推送到 origin 服务器

git push origin master

##### 8. 远程仓库的移除与重命名
git remote rm paul

git remote rename pb paul

##### 9.web修改远程库名称后,重新关联

git remote set-url origin git@gitlab.com:redpanda2017/Pharm_plugin_v3.git
