-- phpMyAdmin SQL Dump
-- version 4.4.15
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2016-06-18 17:04:52
-- 服务器版本： 10.1.8-MariaDB
-- PHP Version: 5.4.45

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
  `log` text NOT NULL,
  `ip` varchar(16) NOT NULL,
  `t` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
(7, 5, 'database/backup', '数据库备份', 'menu-icon fa fa-floppy-o', '', 1, 7),
(8, 5, 'database/recovery', '数据还原', 'menu-icon fa fa-undo', '数据库还原', 1, 8),
(9, 5, 'database/optimize', '数据优化', '', '', 0, 9),
(10, 5, 'database/repair', '数据修复', '', '', 0, 10),
(11, 0, '#', '用户及权限', 'menu-icon fa fa-users', '用户管理，用户组管理', 1, 11),
(12, 11, 'user/index', '用户管理', 'menu-icon fa fa-user', '用户列表、新增、编辑、删除管理', 1, 12),
(13, 11, 'group/index', '分组权限', 'menu-icon fa fa-lock', '权限组列表、新增、编辑、删除管理', 1, 13);

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
('footer', '©2016 春燕网络', '版权信息', '长度255个汉字内', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `cy_user`
--

CREATE TABLE IF NOT EXISTS `cy_user` (
  `uid` int(11) unsigned NOT NULL COMMENT '管理员ID',
  `ugid` int(10) unsigned NOT NULL COMMENT '用户组ID',
  `username` varchar(100) DEFAULT NULL COMMENT '管理员账号',
  `avatar` varchar(255) NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `birthday` int(10) unsigned NOT NULL,
  `tel` varchar(20) NOT NULL,
  `qq` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(32) DEFAULT NULL COMMENT '管理员密码',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账户状态，禁用为0   启用为1',
  `identifier` varchar(32) NOT NULL,
  `token` varchar(32) NOT NULL,
  `salt` varchar(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_user`
--

INSERT INTO `cy_user` (`uid`, `ugid`, `username`, `avatar`, `sex`, `birthday`, `tel`, `qq`, `email`, `password`, `status`, `identifier`, `token`, `salt`) VALUES
(1, 1, 'admin', '', 0, 1465994454, '15881295252', '331349451', 'admin@huikon.cn', 'e62e76cff8e27165bbf2eb429506da72', 1, 'c0930c8b3f55a38ca1a082a517016ba8', '22abcbe8561172fd476558bc1d979c9c', 'wxfVNZV4xT');

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
(1, '超级管理员', 1, '1,2,3,4,5,6,7,8,9,10,11,12,13');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cy_menu`
--
ALTER TABLE `cy_menu`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
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
