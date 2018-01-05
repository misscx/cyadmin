# CYAdmin

CYAdmin，基于ThinkPHP5+aceadmin的通用后台管理系统。

## 环境需求：

PHP 5.4.0+，PDO、CURL扩展，MySQL5.0+

## 安装说明：

1、将application/config_bak.php重命名为config.php，适当修改配置，对于懒人默认配置可满足使用，也可自行修改。

2、将application/database _bak.php重命名为database.php，并修改数据库配置，主要有服务器地址、数据库名、数据库用户名、数据库密码、数据库连接端口等。

3、将cycms.sql文件导入数据库。

4、完成安装，打开网站URL查看效果。

## 后台地址：
http://url/admin/
若安装后打不开，请注意ThinkPHP的Rewrite规则在当前服务器是否适用。
## 管理员用户及密码：

admin admin

## 其它

为什么要做这个？这个项目其实是从ThinkPHP5内测版就开始在弄了，主要是学习ThinkPHP5，之前有个基于3.2.x版的，但没开源出来。