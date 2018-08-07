#### MySQL建立PGx数据库的过程记录
##### 具体步骤
    1. 创建数据库
        mysql>create database db_PGx;
    2. 导入/创建列表
        如果由列表存在,则导入数据;
        mysql>source /var/work/mysql/websites.sql
        如果列表不存在
