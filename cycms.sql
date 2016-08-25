-- phpMyAdmin SQL Dump
-- version 4.4.15
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2016-06-25 17:06:13
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
-- 表的结构 `cy_article`
--

CREATE TABLE IF NOT EXISTS `cy_article` (
  `aid` int(11) NOT NULL,
  `cid` int(11) NOT NULL COMMENT '分类id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `description` varchar(255) NOT NULL COMMENT '摘要',
  `image` varchar(255) NOT NULL COMMENT '缩略图',
  `t` int(10) unsigned NOT NULL COMMENT '时间',
  `stick` tinyint(1) NOT NULL COMMENT '0普通，1置顶',
  `n` int(10) unsigned NOT NULL COMMENT '点击'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_banner`
--

CREATE TABLE IF NOT EXISTS `cy_banner` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `url` varchar(255) NOT NULL COMMENT '网址',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `o` int(11) NOT NULL COMMENT '排序',
  `status` tinyint(1) NOT NULL COMMENT '状态'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_category`
--

CREATE TABLE IF NOT EXISTS `cy_category` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL COMMENT '父ID',
  `type` tinyint(1) NOT NULL COMMENT '0文章，1外链',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `url` varchar(255) NOT NULL COMMENT '外链',
  `description` varchar(255) NOT NULL COMMENT '描述',
  `o` int(11) NOT NULL COMMENT '排序',
  `listtemplate` varchar(100) NOT NULL COMMENT '列表模板',
  `contenttemplate` varchar(100) NOT NULL COMMENT '内容模板'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_content`
--

CREATE TABLE IF NOT EXISTS `cy_content` (
  `aid` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_link`
--

CREATE TABLE IF NOT EXISTS `cy_link` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '网址',
  `logo` varchar(255) NOT NULL COMMENT '图标',
  `o` int(11) NOT NULL COMMENT '排序'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_menu`
--

INSERT INTO `cy_menu` (`id`, `pid`, `url`, `title`, `icon`, `tips`, `status`, `o`) VALUES
(1, 0, 'index/index', '控制台', 'menu-icon fa fa-tachometer', '经常查看操作日志，发现异常以便及时追查原因。', 1, 1),
(2, 0, '#', '开发选项', 'menu-icon fa fa-cogs', '', 1, 2),
(3, 2, 'menu/index', '后台菜单', 'menu-icon fa  fa-folder-o', '开发新功能，新增、修改、删除后台菜单。', 1, 3),
(4, 2, 'variable/index', '自定义变量', 'menu-icon fa  fa-circle-o', '可新增、修改、删除后台自定义变量，方便后台模板直接调用', 1, 4),
(5, 0, '#', '系统设置', 'menu-icon fa fa-cog', '', 1, 5),
(6, 5, 'setting/index', '网站设置', 'menu-icon fa  fa-info-circle', '网站设置，含自定义变量值的设置。', 1, 6),
(7, 5, 'database/backup', '数据库备份', 'menu-icon fa fa-floppy-o', '建议定期备份网站数据库，以便网站故障时时行数据回复。', 1, 7),
(8, 5, 'database/recovery', '数据还原', 'menu-icon fa fa-undo', '将备份在数据库文件还原致数据库。', 1, 8),
(9, 5, 'database/optimize', '数据优化', '', '', 0, 9),
(10, 5, 'search/index', '功能搜索', '', '后台功能搜索', 0, 10),
(11, 5, 'database/repair', '数据修复', '', '', 0, 11),
(12, 0, '#', '用户权限', 'menu-icon fa fa-users', '用户管理，用户组管理', 1, 12),
(13, 12, 'user/index', '用户管理', 'menu-icon fa fa-user', '用户列表、新增、编辑、删除管理', 1, 12),
(14, 12, 'group/index', '分组权限', 'menu-icon fa fa-lock', '权限组列表、新增、编辑、删除管理', 1, 14),
(15, 0, '#', '网站管理', 'menu-icon fa fa-desktop', '网站内空管理', 1, 15),
(16, 15, 'article/index', '文章管理', '', '网站文章管理', 1, 16),
(17, 15, 'article/add', '新增文章', '', '新增文章', 1, 17),
(18, 15, 'article/edit', '编辑文章', '', '', 0, 18),
(19, 15, 'article/save', '文章保存', '', '', 0, 19),
(20, 15, 'category/index', '分类管理', '', '分类管理', 1, 20),
(21, 15, 'category/add', '新增分类', '', '新增分类', 1, 21),
(22, 15, 'category/edit', '编辑文章', '', '', 0, 22),
(23, 15, 'category/save', '保存分类', '', '', 0, 23),
(24, 15, 'banner/index', '横幅管理', '', '横幅管理', 1, 24),
(25, 15, 'banner/add', '新增横幅', '', '', 1, 25),
(26, 15, 'banner/edit', '编辑横幅', '', '', 0, 26),
(27, 15, 'banner/save', '保存横幅', '', '', 0, 27),
(28, 15, 'link/index', '友情链接', '友情链接管理', '', 1, 28),
(29, 15, 'link/add', '新增链接', '', '', 1, 29),
(30, 15, 'link/edit', '编辑链接', '', '', 0, 30),
(31, 15, 'link/save', '保存链接', '', '', 0, 31),
(32, 0, '#', '个人中心', 'menu-icon fa fa-user', '', 1, 32),
(33, 32, 'profile/index', '个人资料', 'menu-icon fa fa-user', '用户个人资料修改', 1, 33),
(34, 32, 'logout/index', '退出登录', 'menu-icon fa fa-power-off', '', 1, 34);

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
  `salt` varchar(10) NOT NULL,
  `skin` varchar(20) NOT NULL DEFAULT 'no-skin'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_user`
--

INSERT INTO `cy_user` (`uid`, `ugid`, `username`, `avatar`, `sex`, `birthday`, `tel`, `qq`, `email`, `password`, `status`, `identifier`, `token`, `salt`, `skin`) VALUES
(1, 1, 'admin', '', 0, 1465920000, '13800138000', '10000', 'admin@huikon.cn', 'e62e76cff8e27165bbf2eb429506da72', 1, '1fdc06648dff12baaca6dfcd9ac5f3ab', 'f74c0728a87e2c0afb76aaa4563a1bf1', 'vy6EtSQkD4', 'no-skin');

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
(1, '超级管理员', 1, '1,2,3,4,5,6,7,8,9,10,26,11,12,13,14,15,16,17,18,19,20,21,22,27,28,29,30,31,34,32,33,23,24,25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cy_article`
--
ALTER TABLE `cy_article`
  ADD PRIMARY KEY (`aid`),
  ADD KEY `cid` (`cid`) USING BTREE;

--
-- Indexes for table `cy_banner`
--
ALTER TABLE `cy_banner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `o` (`o`),
  ADD KEY `s` (`status`);

--
-- Indexes for table `cy_category`
--
ALTER TABLE `cy_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`) USING BTREE;

--
-- Indexes for table `cy_content`
--
ALTER TABLE `cy_content`
  ADD KEY `aid` (`aid`),
  ADD INDEX(`aid`);

--
-- Indexes for table `cy_link`
--
ALTER TABLE `cy_link`
  ADD PRIMARY KEY (`id`),
  ADD KEY `o` (`o`);

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
-- AUTO_INCREMENT for table `cy_article`
--
ALTER TABLE `cy_article`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cy_banner`
--
ALTER TABLE `cy_banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cy_category`
--
ALTER TABLE `cy_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cy_link`
--
ALTER TABLE `cy_link`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cy_log`
--
ALTER TABLE `cy_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cy_menu`
--
ALTER TABLE `cy_menu`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
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
