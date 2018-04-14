# CYAdmin说明

CYAdmin，基于ThinkPHP5+aceadmin的通用后台管理系统。

## 环境需求：

PHP 5.6.0+，PDO扩展，MySQL5.0+

## 安装说明：

### 手动安装

1、下载本源码至网站根目录。

2、将config/database_bak.php重命名为database.php，并修改数据库配置，主要有服务器地址、数据库名、数据库用户名、数据库密码、数据库连接端口等。

3、将database/cycms.sql文件手动导入数据库。

4、完成安装，打开网站URL查看效果。

### 命令安装

注意：命令安装需git支持。

1、先cd到网站根目录，再执行如下命令：

```
git clone https://gitee.com/hanchuan/cycms.git ./
```

2、将database_bak.php重名命为 database.php，命令如下：

```
mv ./config/database_bak.php ./config/database.php
```

3、修改数据库配置

```
vi ./config/database.php
```

修改数据库名、数据库用户、数据库用户密码、数据库端口、数据表前辍等配置。

4、执行数据迁移，命令如下：

```
php think migrate:run
```

5、完成安装，打开网站URL查看效果。

## 后台地址：

http://url/admin/
若安装后打不开，请注意ThinkPHP的Rewrite规则在当前服务器是否适用。

## 管理员用户及密码：

admin admin

## 其它

为什么要做这个？这个项目其实是从ThinkPHP5内测版就开始在弄了，主要是学习ThinkPHP5，之前有个基于3.2.x版的，但没开源出来。

## 演示地址

http://cyadmin.mychunyan.com/admin

admin admin
