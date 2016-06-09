-- phpMyAdmin SQL Dump
-- version 4.4.15
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2016-06-09 16:52:35
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
-- 表的结构 `cy_auth_group`
--

CREATE TABLE IF NOT EXISTS `cy_auth_group` (
  `id` smallint(5) unsigned NOT NULL,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(80) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_auth_group`
--

INSERT INTO `cy_auth_group` (`id`, `title`, `status`, `rules`) VALUES
(30, '超级管理组', 1, '1,2,3,14,15,16,17,18,19,21,25,4,5,6,9,11,24,35,36,37,38,12,13,22,23');

-- --------------------------------------------------------

--
-- 表的结构 `cy_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `cy_auth_group_access` (
  `uid` smallint(5) unsigned NOT NULL,
  `group_id` smallint(5) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_auth_group_access`
--

INSERT INTO `cy_auth_group_access` (`uid`, `group_id`) VALUES
(1, 30),
(2, 31),
(3, 33),
(4, 31),
(5, 31);

-- --------------------------------------------------------

--
-- 表的结构 `cy_auth_rule`
--

CREATE TABLE IF NOT EXISTS `cy_auth_rule` (
  `id` smallint(6) NOT NULL,
  `name` varchar(80) NOT NULL DEFAULT '',
  `title` varchar(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` smallint(5) NOT NULL COMMENT '父级ID',
  `sort` tinyint(4) NOT NULL DEFAULT '50' COMMENT '排序',
  `create_time` int(11) NOT NULL COMMENT '创建时间'
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_auth_rule`
--

INSERT INTO `cy_auth_rule` (`id`, `name`, `title`, `type`, `status`, `condition`, `pid`, `sort`, `create_time`) VALUES
(36, 'Admin/admin_list', '管理员列表', 1, 1, '', 35, 50, 1444546437),
(35, 'Admin/index', '系统管理', 1, 1, '', 0, 50, 1444582187),
(37, 'Admin/auth_group', '用户组', 1, 1, '', 35, 50, 1445439984),
(38, 'Admin/auth_rule', '权限菜单', 1, 1, '', 35, 50, 1445439984);

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
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_log`
--

INSERT INTO `cy_log` (`id`, `username`, `log`, `ip`, `t`) VALUES
(18, 'admin', '登录成功。', '127.0.0.1', 1465458707),
(19, 'admin', '登录成功。', '127.0.0.1', 1465458964),
(20, 'admin', '登录成功。', '127.0.0.1', 1465459146),
(21, 'admin', '登录成功。', '127.0.0.1', 1465459191),
(22, 'admin', '登录成功。', '127.0.0.1', 1465459633),
(23, 'admin', '登录成功。', '127.0.0.1', 1465459680),
(24, 'admin', '登录成功。', '127.0.0.1', 1465459706),
(25, 'admin', '登录成功。', '127.0.0.1', 1465459734),
(26, 'admin', '登录成功。', '127.0.0.1', 1465459750),
(27, 'admin', '登录成功。', '127.0.0.1', 1465459769),
(28, 'admin', '登录成功。', '127.0.0.1', 1465459902),
(29, 'admin', '登录成功。', '127.0.0.1', 1465460104),
(30, 'admin', '登录成功。', '127.0.0.1', 1465460132),
(31, 'admin', '登录成功。', '127.0.0.1', 1465460172),
(32, 'admin', '登录成功。', '127.0.0.1', 1465460357),
(33, 'admin', '登录成功。', '127.0.0.1', 1465460460),
(34, 'admin', '登录成功。', '127.0.0.1', 1465460599),
(35, 'admin', '登录成功。', '127.0.0.1', 1465460717),
(36, 'admin', '登录成功。', '127.0.0.1', 1465460916),
(37, 'admin', '登录成功。', '127.0.0.1', 1465460944),
(38, 'admin', '登录成功。', '127.0.0.1', 1465461219),
(39, 'admin', '登录成功。', '127.0.0.1', 1465461251);

-- --------------------------------------------------------

--
-- 表的结构 `cy_setting`
--

CREATE TABLE IF NOT EXISTS `cy_setting` (
  `k` varchar(100) NOT NULL COMMENT '变量',
  `v` text NOT NULL COMMENT '值',
  `type` tinyint(1) NOT NULL COMMENT '0系统，1自定义',
  `name` varchar(255) NOT NULL COMMENT '说明'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_setting`
--

INSERT INTO `cy_setting` (`k`, `v`, `type`, `name`) VALUES
('title', '春燕网络通用后台管理系统', 0, ''),
('sitename', 'CYAdmin', 0, ''),
('keywords', '关键词', 0, ''),
('description', '网站描述', 0, ''),
('footer', '2016©春燕网络', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `cy_user`
--

CREATE TABLE IF NOT EXISTS `cy_user` (
  `uid` int(11) unsigned NOT NULL COMMENT '管理员ID',
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

INSERT INTO `cy_user` (`uid`, `username`, `password`, `status`, `identifier`, `token`, `salt`) VALUES
(1, 'admin', 'e62e76cff8e27165bbf2eb429506da72', 1, 'f9899bf8e8b2f2ad99820a71a4cabf68', '2131a71c28e0ac8effeddad1e7ec0c52', 'J5Z5VVm6xX');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cy_auth_group`
--
ALTER TABLE `cy_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cy_auth_group_access`
--
ALTER TABLE `cy_auth_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `cy_auth_rule`
--
ALTER TABLE `cy_auth_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `cy_log`
--
ALTER TABLE `cy_log`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cy_auth_group`
--
ALTER TABLE `cy_auth_group`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `cy_auth_rule`
--
ALTER TABLE `cy_auth_rule`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `cy_log`
--
ALTER TABLE `cy_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `cy_user`
--
ALTER TABLE `cy_user`
  MODIFY `uid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
