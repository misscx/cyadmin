SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";



--

-- --------------------------------------------------------

--
-- 表的结构 `cy_article`
--

CREATE TABLE `cy_article` (
  `aid` int(11) NOT NULL,
  `cid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '文章标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '文章关键词',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '文章描述',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图',
  `content` text NOT NULL DEFAULT '' COMMENT '内容',
  `stick` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0普通，1置顶',
  `t` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布时间',
  `n` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_banner`
--

CREATE TABLE `cy_banner` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT 'Banner图',
  `o` int(11) NOT NULL DEFAULT 0 COMMENT '排序，越小越靠前',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0禁止，1显示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_category`
--

CREATE TABLE `cy_category` (
  `id` int(11) NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类ID',
  `type` int(8) NOT NULL DEFAULT 0 COMMENT '类型：0普通，1单页，2外链',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '文章关键词',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '文章描述',
  `content` text NOT NULL DEFAULT '' COMMENT '内容',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '外链地址',
  `listtemplate` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模版',
  `contenttemplate` varchar(100) NOT NULL DEFAULT '' COMMENT '内容模版',
  `o` int(11) NOT NULL DEFAULT 0 COMMENT '排序，越小越靠前'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_link`
--

CREATE TABLE `cy_link` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '站标',
  `ip` varchar(16) NOT NULL DEFAULT '' COMMENT 'IP',
  `o` int(11) NOT NULL DEFAULT 0 COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_log`
--

CREATE TABLE `cy_log` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `log` text NOT NULL DEFAULT '' COMMENT '日志',
  `ip` varchar(16) NOT NULL DEFAULT '' COMMENT 'IP',
  `t` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_menu`
--

CREATE TABLE `cy_menu` (
  `id` int(11) NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '标图',
  `tips` varchar(255) NOT NULL DEFAULT '' COMMENT '提示语',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0隐藏，1显示',
  `o` int(11) NOT NULL DEFAULT 0 COMMENT '排序，越小越靠前'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_menu`
--

INSERT INTO `cy_menu` (`id`, `pid`, `url`, `title`, `icon`, `tips`, `status`, `o`) VALUES
(1, 0, 'index/index', '控制台', 'menu-icon fa fa-tachometer', '经常查看操作日志，发现异常以便及时追查原因。', 1, 1),
(2, 0, '#', '开发选项', 'menu-icon fa fa-cogs', '', 1, 2),
(3, 2, 'menu/index', '后台菜单', 'menu-icon fa  fa-folder-o', '开发新功能，新增、修改、删除后台菜单。', 1, 3),
(4, 2, 'variable/index', '自定义变量', 'menu-icon fa  fa-circle-o', '可新增、修改、删除后台自定义变量，方便后台模板直接调用。', 1, 4),
(5, 0, '#', '系统设置', 'menu-icon fa fa-cog', '', 1, 5),
(6, 5, 'setting/index', '网站设置', 'menu-icon fa  fa-info-circle', '网站设置，含自定义变量值的设置。', 1, 6),
(7, 5, 'database/backup', '数据库备份', 'menu-icon fa fa-floppy-o', '建议定期备份网站数据库，以便网站故障时能及时恢复数据。', 1, 7),
(8, 5, 'database/recovery', '数据还原', 'menu-icon fa fa-undo', '将备份在数据库文件还原致数据库。', 1, 8),
(9, 5, 'database/optimize', '数据优化', '', '', 0, 9),
(10, 5, 'search/index', '功能搜索', '', '找不到后台功能搜索一下就能找到。', 0, 10),
(11, 5, 'database/repair', '数据修复', '', '', 0, 11),
(12, 0, '#', '用户权限', 'menu-icon fa fa-users', '用户管理，用户组管理。', 1, 12),
(13, 12, 'user/index', '用户管理', 'menu-icon fa fa-user', '用户列表、新增、编辑、删除管理。', 1, 12),
(14, 12, 'group/index', '分组权限', 'menu-icon fa fa-lock', '权限组列表、新增、编辑、删除管理。', 1, 14),
(15, 0, '#', '网站管理', 'menu-icon fa fa-desktop', '网站内空管理', 1, 15),
(16, 15, 'article/index', '文章管理', '', '网站文章管理，对网站文章进行新增、修改、删除操作。', 1, 16),
(17, 15, 'article/add', '新增文章', '', '新增网站文章。', 1, 17),
(18, 15, 'article/edit', '编辑文章', '', '', 0, 18),
(19, 15, 'article/save', '文章保存', '', '', 0, 19),
(20, 15, 'category/index', '分类管理', '', '文章分类管理，对分类进行新增、修改、删除操作。', 1, 20),
(21, 15, 'category/add', '新增分类', '', '新增文章分类', 1, 21),
(22, 15, 'category/edit', '编辑文章', '', '', 0, 22),
(23, 15, 'category/save', '保存分类', '', '', 0, 23),
(24, 15, 'banner/index', '横幅管理', '', '横幅管理，可对网站横幅广告进行新增、修改、删除操作。', 1, 24),
(25, 15, 'banner/add', '新增横幅', '', '', 1, 25),
(26, 15, 'banner/edit', '编辑横幅', '', '', 0, 26),
(27, 15, 'banner/save', '保存横幅', '', '', 0, 27),
(28, 15, 'link/index', '友情链接', '', '友情链接管理，对网站友情链接进行新增、修改、删除操作。', 1, 28),
(29, 15, 'link/add', '新增链接', '', '新增网站友情连接。', 1, 29),
(30, 15, 'link/edit', '编辑链接', '', '', 0, 30),
(31, 15, 'link/save', '保存链接', '', '', 0, 31),
(32, 0, '#', '个人中心', 'menu-icon fa fa-user', '', 1, 32),
(33, 32, 'profile/index', '个人资料', 'menu-icon fa fa-user', '用户个人资料修改。', 1, 33),
(34, 32, 'logout/index', '退出登录', 'menu-icon fa fa-power-off', '', 1, 34);

-- --------------------------------------------------------

--
-- 表的结构 `cy_migrations`
--

CREATE TABLE `cy_migrations` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `breakpoint` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_migrations`
--

INSERT INTO `cy_migrations` (`version`, `migration_name`, `start_time`, `end_time`, `breakpoint`) VALUES
(20180414063451, 'User', '2019-11-26 11:16:42', '2019-11-26 11:16:42', 0),
(20180414083712, 'UserGroup', '2019-11-26 11:16:42', '2019-11-26 11:16:42', 0),
(20180414085417, 'Log', '2019-11-26 11:16:42', '2019-11-26 11:16:42', 0),
(20180414090927, 'Link', '2019-11-26 11:16:42', '2019-11-26 11:16:43', 0),
(20180414120957, 'Article', '2019-11-26 11:16:43', '2019-11-26 11:16:43', 0),
(20180414123404, 'Banner', '2019-11-26 11:16:43', '2019-11-26 11:16:43', 0),
(20180414124141, 'Category', '2019-11-26 11:16:43', '2019-11-26 11:16:43', 0),
(20180414131647, 'Menu', '2019-11-26 11:16:43', '2019-11-26 11:16:44', 0),
(20191023084047, 'UserAuth', '2019-11-26 11:16:44', '2019-11-26 11:16:45', 0);

-- --------------------------------------------------------

--
-- 表的结构 `cy_user`
--

CREATE TABLE `cy_user` (
  `uid` int(11) NOT NULL,
  `ugid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户组ID',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `sex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '姓别：0保密，1男，2女',
  `birthday` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '生日',
  `tel` varchar(20) NOT NULL DEFAULT '' COMMENT '电话号码',
  `qq` varchar(20) NOT NULL DEFAULT '' COMMENT 'QQ',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '用户状态，0禁用，1启用',
  `identifier` varchar(32) NOT NULL DEFAULT '' COMMENT '登录标识',
  `token` varchar(32) NOT NULL DEFAULT '' COMMENT '登录Token',
  `salt` varchar(10) NOT NULL DEFAULT '' COMMENT '密码盐',
  `skin` varchar(20) NOT NULL DEFAULT 'no-skin' COMMENT '皮肤',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_user`
--

INSERT INTO `cy_user` (`uid`, `ugid`, `username`, `password`, `avatar`, `sex`, `birthday`, `tel`, `qq`, `email`, `status`, `identifier`, `token`, `salt`, `skin`, `create_time`) VALUES
(1, 1, 'admin', 'e62e76cff8e27165bbf2eb429506da72', '', 0, 1574767002, '15881295252', '331349451', 'admin@huikon.cn', 1, '', '', '', 'no-skin', 1574767002);

-- --------------------------------------------------------

--
-- 表的结构 `cy_user_auth`
--

CREATE TABLE `cy_user_auth` (
  `id` int(11) NOT NULL,
  `uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `cy_user_group`
--

CREATE TABLE `cy_user_group` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '组状态，0禁用，1启用',
  `auth` text NOT NULL DEFAULT '' COMMENT '组权限'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cy_user_group`
--

INSERT INTO `cy_user_group` (`id`, `title`, `status`, `auth`) VALUES
(1, '超级管理员', 1, '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,727,728,729,730,731,732,733,734,735,736,737,738,739,740,741,742,743,744,745,746,747,748,749,750,751,752,753,754,755,756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,773,774,775,776,777,778,779,780,781,782,783,784,785,786,787,788,789,790,791,792,793,794,795,796,797,798,799,800,801,802,803,804,805,806,807,808,809,810,811,812,813,814,815,816,817,818,819,820,821,822,823,824,825,826,827,828,829,830,831,832,833,834,835,836,837,838,839,840,841,842,843,844,845,846,847,848,849,850,851,852,853,854,855,856,857,858,859,860,861,862,863,864,865,866,867,868,869,870,871,872,873,874,875,876,877,878,879,880,881,882,883,884,885,886,887,888,889,890,891,892,893,894,895,896,897,898,899,900,901,902,903,904,905,906,907,908,909,910,911,912,913,914,915,916,917,918,919,920,921,922,923,924,925,926,927,928,929,930,931,932,933,934,935,936,937,938,939,940,941,942,943,944,945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961,962,963,964,965,966,967,968,969,970,971,972,973,974,975,976,977,978,979,980,981,982,983,984,985,986,987,988,989,990,991,992,993,994,995,996,997,998,999,1000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cy_article`
--
ALTER TABLE `cy_article`
  ADD PRIMARY KEY (`aid`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `cy_banner`
--
ALTER TABLE `cy_banner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `o` (`o`);

--
-- Indexes for table `cy_category`
--
ALTER TABLE `cy_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`,`o`);

--
-- Indexes for table `cy_link`
--
ALTER TABLE `cy_link`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `pid` (`pid`,`o`);

--
-- Indexes for table `cy_migrations`
--
ALTER TABLE `cy_migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `cy_user`
--
ALTER TABLE `cy_user`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `cy_user_auth`
--
ALTER TABLE `cy_user_auth`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cy_user_group`
--
ALTER TABLE `cy_user_group`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `cy_article`
--
ALTER TABLE `cy_article`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cy_banner`
--
ALTER TABLE `cy_banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cy_category`
--
ALTER TABLE `cy_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cy_link`
--
ALTER TABLE `cy_link`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cy_log`
--
ALTER TABLE `cy_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cy_menu`
--
ALTER TABLE `cy_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- 使用表AUTO_INCREMENT `cy_user`
--
ALTER TABLE `cy_user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `cy_user_auth`
--
ALTER TABLE `cy_user_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cy_user_group`
--
ALTER TABLE `cy_user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;
