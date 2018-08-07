#### MySQL建立PGx数据库的过程记录

##### 基础操作
启动/关闭/重启服务
    systemctl start/stop/restart  mysqld.service　　　
查看是服务状态
    systemctl status  mysqld.service
进入MySQL
        mysql -u root -p ****

SHOW DATABASES;
SHOW TABLES;
SHOW COLUMNS FROM apps;

SELECT * from websites;
SELECT DISTINCT country from websites;
SELECT * FROM websites WHERE country='CN';
SELECT * FROM websites WHERE id between 3 and 4;
SELECT * FROM websites WHERE id in(1,2,5);
SELECT * FROM websites WHERE url like '%www%';
SELECT * FROM websites WHERE url not like '%www%';
/   查询 EMP 表中 Ename 列中有 M 的值，M 为要查询内容中的模糊信息。
    % 表示多个字值，_ 下划线表示一个字符；
    M% : 为能配符，正则表达式，表示的意思为模糊查询信息为 M 开头的。
    %M% : 表示查询包含M的所有内容。
    %M_ : 表示查询以M在倒数第二位的所有内容。

    % 替代 0 个或多个字符
    _ 替代一个字符
    [charlist]字符列中的任何单一字符
    [^charlist]或[!charlist]    不在字符列中的任何单一字符
/

/
其中搭配以上通配符可以让LIKE命令实现多种技巧：
1、LIKE'Mc%' 将搜索以字母 Mc 开头的所有字符串（如 McBadden）。
2、LIKE'%inger' 将搜索以字母 inger 结尾的所有字符串（如 Ringer、Stringer）。
3、LIKE'%en%' 将搜索在任何位置包含字母 en 的所有字符串（如 Bennet、Green、McBadden）。
4、LIKE'_heryl' 将搜索以字母 heryl 结尾的所有六个字母的名称（如 Cheryl、Sheryl）。
5、LIKE'[CK]ars[eo]n' 将搜索下列字符串：Carsen、Karsen、Carson 和 Karson（如 Carson）。
6、LIKE'[M-Z]inger' 将搜索以字符串 inger 结尾、以从 M 到 Z 的任何单个字母开头的所有名称（如 Ringer）。
7、LIKE'M[^c]%' 将搜索以字母 M 开头，并且第二个字母不是 c 的所有名称（如MacFeather）。
/


SELECT * FROM websites WHERE name REGEXP '^[GFs]';
/REGEXP 正则表达式/

SELECT * FROM websites WHERE country='CN'AND alexa > 50;
SELECT * FROM websites ORDER BY alexa;
SELECT * FROM websites ORDER BY alexa DESC;
SELECT * FROM websites ORDER BY country,alexa;

INSERT INTO websites (name, url, alexa, country) VALUES ('百度','https://www.baidu.com/','4','CN');
INSERT INTO websites (name, url, country) VALUES ('stackoverflow', 'http://stackoverflow.com/', 'IND');

UPDATE websites SET alexa='5000', country='USA' WHERE name='菜鸟教程';
DELETE FROM websites WHERE name='stackoverflow' AND id=8;



##### 高级操作

SELECT * FROM websites LIMIT 2;
SELECT name AS n, country AS c FROM websites;
SELECT name, CONCAT(url, ', ', alexa, ', ', country) AS site_info FROM websites;
SELECT w.name, w.url, a.count, a.date FROM websites AS w, access_log AS a WHERE a.site_id=w.id and w.name="菜鸟教程";
SELECT w.name, a.date, CONCAT(w.id,'\t', a.site_id) AS ID FROM websites as w, access_log as a WHERE a.site_id=w.id;
SELECT websites.id, websites.name, access_log.site_id, access_log.count, access_log.date FROM websites, access_log;
SELECT websites.id, websites.name, access_log.count, access_log.site_id, access_log.date FROM websites INNER JOIN access_log ON websites.id=access_log.site_id;
SELECT websites.id, websites.name, access_log.site_id, access_log.count, access_log.date FROM websites INNER JOIN access_log ON websites.id=access_log.site_id ORDER BY id;
SELECT websites.id, websites.name, access_log.site_id, access_log.count, access_log.date FROM websites LEFT JOIN access_log ON websites.id=access_log.site_id ORDER BY id;
SELECT websites.id, websites.name, access_log.site_id, access_log.count, access_log.date FROM access_log RIGHT JOIN websites ON websites.id=access_log.site_id ORDER BY id;
SELECT country FROM websites UNION SELECT site_id FROM access_log;

CREATE TABLE Websites SELECT * FROM websites;
INSERT INTO Websites SELECT * FROM websites;
CREATE TABLE Persons (Id_P int NOT NULL, LastName varchar(255) NOT NULL, FirstName varchar(255), Address varchar(255), City varchar(255), PRIMARY KEY (Id_P));
/
    NOT NULL - 指示某列不能存储 NULL 值。
    UNIQUE - 保证某列的每行必须有唯一的值。
    PRIMARY KEY - NOT NULL 和 UNIQUE 的结合。确保某列（或两个列多个列的结合）有唯一标识，有助于更容易更快速地找到表中的一个特定的记录。
    FOREIGN KEY - 保证一个表中的数据匹配另一个表中的值的参照完整性。
    CHECK - 保证列中的值符合指定的条件。
    DEFAULT - 规定没有给列赋值时的默认值。
/

####函数

SELECT AVG(count) AS CountAverage FROM access_log;
SELECT * FROM access_log WHERE count > (SELECT AVG(count) FROM access_log);
SELECT COUNT(*) AS nums FROM access_log;
SELECT COUNT(DISTINCT site_id ) AS nums FROM access_log;
SELECT * FROM websites WHERE alexa=(SELECT MIN(alexa) AS min_alexa FROM websites);
SELECT site_id, SUM(access_log.count) AS nums FROM access_log GROUP BY site_id;
SELECT websites.name,COUNT(access_log.aid) AS nums FROM access_log LEFT JOIN websites ON access_log.site_id=websites.id GROUP BY websites.name;
SELECT websites.name, SUM(access_log.count) AS nums FROM (access_log INNER JOIN websites ON access_log.site_id=websites.id) GROUP BY websites.name; HAVING SUM(access_log.count) > 200;
SELECT UCASE(name) FROM websites;
SELECT LCASE(name) FROM websites;
SELECT MID(name,1,4) AS ShortTitle FROM websites;
SELECT name, LENGTH(name) AS Len FROM websites;
SELECT ROUND(id, 2) FROM websites;
SELECT ROUND(1.298, 5);
SELECT name, url, Now() AS date FROM websites;
SELECT name, url, DATE_FORMAT(Now(),'%Y-%m-%d-%H:%i:%s') AS date FROM websites;

        
