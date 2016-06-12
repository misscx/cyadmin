-- phpMyAdmin SQL Dump
-- version 4.4.15
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2016-06-13 00:26:00
-- 服务器版本： 10.1.9-MariaDB
-- PHP Version: 7.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cycms`
--

-- --------------------------------------------------------

--
-- 表的结构 `cy_log`
--

CREATE TABLE IF NOT EXISTS `cy_log` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `log` varchar(255) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `t` int(10) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_log`
--

INSERT INTO `cy_log` (`id`, `username`, `log`, `ip`, `t`) VALUES
(1, 'admin', '删除菜单，ID：1,2,3,4,5,6,7', '127.0.0.1', 1465639847),
(2, 'admin', '编辑菜单，ID:8', '127.0.0.1', 1465647648),
(3, 'admin', '编辑菜单，ID:8', '127.0.0.1', 1465647703),
(4, 'admin', '编辑菜单，ID:3', '127.0.0.1', 1465648443),
(5, 'admin', '编辑菜单，ID:3', '127.0.0.1', 1465648453),
(6, 'admin', '编辑菜单，ID:5', '127.0.0.1', 1465649425),
(7, 'admin', '编辑菜单，ID:5', '127.0.0.1', 1465649445),
(8, 'admin', '登录成功。', '127.0.0.1', 1465734143),
(9, 'admin', '删除自定义变量，ID：test1', '127.0.0.1', 1465739987),
(10, 'admin', '删除自定义变量，ID：footer,test', '127.0.0.1', 1465740000),
(11, 'admin', '编辑菜单，变量名:test', '127.0.0.1', 1465741468),
(12, 'admin', '编辑菜单，变量名:test', '127.0.0.1', 1465741478),
(13, 'admin', '编辑菜单，变量名:test', '127.0.0.1', 1465741531),
(14, 'admin', '编辑菜单，变量名:t', '127.0.0.1', 1465741541),
(15, 'admin', '编辑菜单，变量名:0', '127.0.0.1', 1465741601),
(16, 'admin', '编辑菜单，变量名:变量名', '127.0.0.1', 1465741908),
(17, 'admin', '编辑菜单，变量名:test', '127.0.0.1', 1465743102),
(18, 'admin', '修改网站配置。', '127.0.0.1', 1465745138),
(19, 'admin', '修改网站配置。', '127.0.0.1', 1465745164),
(20, 'admin', '修改网站配置。', '127.0.0.1', 1465745177),
(21, 'admin', '修改网站配置。', '127.0.0.1', 1465748243),
(22, 'admin', '修改网站配置。', '127.0.0.1', 1465748644),
(23, 'admin', '编辑菜单，变量名:test', '127.0.0.1', 1465748747);

-- --------------------------------------------------------

--
-- 表的结构 `cy_menu`
--

CREATE TABLE IF NOT EXISTS `cy_menu` (
  `id` int(11) unsigned NOT NULL,
  `pid` int(11) unsigned NOT NULL COMMENT '父级ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '连接',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(100) NOT NULL COMMENT '图标',
  `tips` varchar(255) NOT NULL COMMENT '提示语',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1显示，0隐藏',
  `o` tinyint(4) NOT NULL COMMENT '排序'
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_menu`
--

INSERT INTO `cy_menu` (`id`, `pid`, `url`, `title`, `icon`, `tips`, `status`, `o`) VALUES
(1, 0, 'index/index', '控制台', 'menu-icon fa fa-tachometer', '', 1, 1),
(2, 0, '#', '开发选项', 'menu-icon fa fa-cogs', '', 1, 2),
(3, 2, 'menu/index', '后台菜单', 'menu-icon fa  fa-folder-o', '开发新功能，新增、修改、删除后台菜单。', 1, 3),
(4, 2, 'variable/index', '自定义变量', 'menu-icon fa  fa-circle-o', '秀', 1, 4),
(5, 0, '#', '系统设置', 'menu-icon fa fa-cog', '大', 1, 5),
(6, 5, 'setting/index', '网站设置', 'menu-icon fa  fa-info-circle', '', 1, 6),
(7, 5, 't5/index', '测试', 'menu-icon fa fa-tachometer', '', 1, 7),
(8, 5, 't/t3', '测试5', 'dddd', 'ffff', 1, 10);

-- --------------------------------------------------------

--
-- 表的结构 `cy_setting`
--

CREATE TABLE IF NOT EXISTS `cy_setting` (
  `k` varchar(100) NOT NULL COMMENT '变量',
  `v` varchar(255) NOT NULL COMMENT '值',
  `name` varchar(255) NOT NULL,
  `tips` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '0系统，1自定义',
  `o` int(11) NOT NULL COMMENT '排序'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_setting`
--

INSERT INTO `cy_setting` (`k`, `v`, `name`, `tips`, `type`, `o`) VALUES
('title', '春燕网络通用后台管理系统', '网站名称', '长度255个汉字内', 0, 0),
('sitename', 'CYAdmin', '短标题', '长度255个汉字内', 0, 0),
('keywords', '关键词', '关键词', '长度255个汉字内', 0, 0),
('description', '网站描述', '网站描述', '长度255个汉字内', 0, 0),
('footer', '©2016 春燕网络', '版权信息', '长度255个汉字内', 0, 0),
('test', '你好', '自定义变量', '磊', 1, 0),
('test1', 'have a test', '自定义变量', '', 1, 0),
('tt', '变量值', '自定义变量', '', 1, 0),
('te', '变量值在地', '自定义变量', '', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `cy_user`
--

CREATE TABLE IF NOT EXISTS `cy_user` (
  `uid` int(11) unsigned NOT NULL COMMENT '管理员ID',
  `ugid` int(10) unsigned NOT NULL COMMENT '用户组ID',
  `username` varchar(100) DEFAULT NULL COMMENT '管理员账号',
  `password` varchar(32) DEFAULT NULL COMMENT '管理员密码',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态，禁用为0   启用为1',
  `identifier` varchar(32) NOT NULL,
  `token` varchar(32) NOT NULL,
  `salt` varchar(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_user`
--

INSERT INTO `cy_user` (`uid`, `ugid`, `username`, `password`, `status`, `identifier`, `token`, `salt`) VALUES
(1, 1, 'admin', 'e62e76cff8e27165bbf2eb429506da72', 1, '062a1b558e1a5816e3a33472852130c6', '22fc35f0452d38c52241232847ab3754', 'BnUEjeDRCV');

-- --------------------------------------------------------

--
-- 表的结构 `cy_user_group`
--

CREATE TABLE IF NOT EXISTS `cy_user_group` (
  `id` smallint(5) unsigned NOT NULL,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `auth` text NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_user_group`
--

INSERT INTO `cy_user_group` (`id`, `title`, `status`, `auth`) VALUES
(1, '超级管理组', 1, '\n1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cy_log`
--
ALTER TABLE `cy_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cy_menu`
--
ALTER TABLE `cy_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `url` (`url`),
  ADD KEY `status` (`status`),
  ADD KEY `o` (`o`);

--
-- Indexes for table `cy_setting`
--
ALTER TABLE `cy_setting`
  ADD PRIMARY KEY (`k`),
  ADD KEY `k` (`k`);

--
-- Indexes for table `cy_user`
--
ALTER TABLE `cy_user`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `identifier` (`identifier`,`token`);

--
-- Indexes for table `cy_user_group`
--
ALTER TABLE `cy_user_group`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cy_log`
--
ALTER TABLE `cy_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `cy_menu`
--
ALTER TABLE `cy_menu`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `cy_user`
--
ALTER TABLE `cy_user`
  MODIFY `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `cy_user_group`
--
ALTER TABLE `cy_user_group`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
