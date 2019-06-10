DROP TABLE IF EXISTS `5isns_plugins`;
CREATE TABLE `5isns_plugins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '插件文件名',
  `cnname` varchar(100) NOT NULL DEFAULT '' COMMENT '插件中文名称',
  `author` varchar(100) NOT NULL DEFAULT '' COMMENT '作者',
  `version` varchar(100) NOT NULL DEFAULT '' COMMENT '版本',   
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '插件描述',
  `config` text DEFAULT NULL COMMENT '配置数据',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件表';

DROP TABLE IF EXISTS `5isns_tixian`;
CREATE TABLE `5isns_tixian` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `score` int(11) NOT NULL default '0',   # 提现积分
  `rmb` varchar(100) NOT NULL DEFAULT '' COMMENT '金额',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '账号',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1支付宝',    
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '申请时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通过时间',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='提现表';

DROP TABLE IF EXISTS `5isns_file`;
CREATE TABLE `5isns_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '我的附件，便于清理附件',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT '我的帖子id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常1帖子2文档3话题4会员组5认证材料',  
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` varchar(100) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` varchar(255) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(50) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(15) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `width` mediumint(8) unsigned NOT NULL default '0', # width > 0 则为图片
  `height` mediumint(8) unsigned NOT NULL default '0',  # height
  `comment` char(100) NOT NULL default '',    # 文件注释 方便于搜索
  `score` int(11) NOT NULL default '0',   # 金币
  `downloads` int(11) NOT NULL default '0',   # 下载次数，预留
  `isimage` tinyint(1) NOT NULL default '0',    # 是否为图片
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';


DROP TABLE IF EXISTS `5isns_user`;
CREATE TABLE IF NOT EXISTS `5isns_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userip` varchar(32) NOT NULL COMMENT 'IP',
  `nickname` char(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `username` varchar(32) NOT NULL COMMENT '名称',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `avatar` int(11) DEFAULT '0' COMMENT '头像',
  `usermail` varchar(32) NOT NULL COMMENT '邮箱',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机',
  `regtime` varchar(32) NOT NULL COMMENT '注册时间',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '正常',
  `rz` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否认证,什么认证类型',
  `statusdes` varchar(200) DEFAULT NULL COMMENT '认证描述',
  `userhome` varchar(32) DEFAULT NULL COMMENT '家乡',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `last_login_time` varchar(20) DEFAULT '0' COMMENT '最后登陆时间',
  `last_login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `salt` varchar(20) DEFAULT NULL COMMENT 'salt',
  `logins` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登錄次數',
  `leader_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '上级会员ID',
  `is_inside` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为后台使用者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `usermail` (`usermail`) USING BTREE
)ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

INSERT INTO `5isns_user` (id, nickname, username,password,usermail,salt,is_inside) VALUES (1, 'admin', 'admin', '0dfc7612f607db6c17fd99388e9e5f9c', 'admin@admin.com','1dFlxLhiuLqnUZe9kA',1);

DROP TABLE IF EXISTS `5isns_user_extend`;
CREATE TABLE IF NOT EXISTS `5isns_user_extend` (
  `uid` int(11) NOT NULL COMMENT '会员',
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `expoint1` int(11) DEFAULT '0' COMMENT '扩展积分1',
  `expoint2` int(11) DEFAULT '0' COMMENT '扩展积分2',
  `expoint3` int(11) DEFAULT '0' COMMENT '扩展积分3',
  `doc_num` int(11) DEFAULT '0' COMMENT '文档数量',
  `topic_num` int(11) DEFAULT '0' COMMENT '帖子数量',
  `fensi_num` int(11) DEFAULT '0' COMMENT '粉丝数量',
  `cate_num` int(11) DEFAULT '0' COMMENT '我的话题数量',
  `focus_mydoc_num` int(11) DEFAULT '0' COMMENT '被收藏文档数量',
  `focus_mytopic_num` int(11) DEFAULT '0' COMMENT '被收藏帖子数量',
  `focus_mycate_num` int(11) DEFAULT '0' COMMENT '被关注话题数量',
  `focus_user_num` int(11) DEFAULT '0' COMMENT '关注用户数量',
  `focus_doc_num` int(11) DEFAULT '0' COMMENT '收藏文档数量',
  `focus_topic_num` int(11) DEFAULT '0' COMMENT '收藏帖子数量',
  `focus_cate_num` int(11) DEFAULT '0' COMMENT '关注话题数量',
  `grades` tinyint(1) NOT NULL DEFAULT '0' COMMENT '购买等级',
  `grades_days` int(11) DEFAULT '-1' COMMENT '天数',
  `grades_nums` int(11) DEFAULT '-1' COMMENT '次数',
  `grades_bili` int(11) NOT NULL DEFAULT '0' COMMENT '比例涉及付费内容|下载附件|下载文档',
  `grades_limittime` varchar(255) NOT NULL DEFAULT '0' COMMENT '时间限制',
  `grades_type` varchar(255) NOT NULL DEFAULT '0' COMMENT '权限',  
  `grades_name` varchar(100) DEFAULT NULL COMMENT '购买等级名称',
  `grades_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '购买更新时间',
  `up_grades` tinyint(1) NOT NULL DEFAULT '0' COMMENT '升级等级',
  `up_grades_bili` int(11) NOT NULL DEFAULT '0' COMMENT '比例涉及付费内容|下载附件|下载文档',
  `up_grades_limittime` varchar(255) NOT NULL DEFAULT '0' COMMENT '时间限制',
  `up_grades_type` varchar(255) NOT NULL DEFAULT '0' COMMENT '权限',  
  `up_grades_name` varchar(100) DEFAULT NULL COMMENT '升级等级名称',
  `up_grades_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '升级更新时间',
  `keywords` varchar(200) DEFAULT NULL  COMMENT '关键词',
  `notify_set` text DEFAULT NULL COMMENT '请求数据',
  `mailstatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邮箱是否认证',
  `mobilestatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '手机是否认证',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1通过',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`uid`)
)ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户附加信息表';
INSERT INTO `5isns_user_extend` (uid) VALUES (1);
DROP TABLE IF EXISTS `5isns_rzuser`;
CREATE TABLE IF NOT EXISTS `5isns_rzuser` (
  `uid` int(11) NOT NULL COMMENT '会员',
  `mobile` varchar(200) DEFAULT NULL COMMENT '联系方式',
  `name` varchar(200) DEFAULT NULL COMMENT '真实姓名',
  `statusdes` varchar(200) DEFAULT NULL COMMENT '认证描述',
  `idcard` varchar(32) NOT NULL COMMENT '身份证或机构代码证',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '证件照片',
  `keywords` varchar(200) DEFAULT NULL  COMMENT '关键词',
  `rzdescrib` varchar(200) DEFAULT NULL  COMMENT '关键词',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1个人2企业',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1通过',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`uid`)
)ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户认证表';

DROP TABLE IF EXISTS `5isns_usergrade`;
CREATE TABLE IF NOT EXISTS `5isns_usergrade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '名称',
  `score` int(11) NOT NULL COMMENT '等级所需积分',
  `gmtype` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1购买2升级',
  `type` varchar(32) NOT NULL DEFAULT '0' COMMENT '1发帖2发文档3回帖4查看付费内容5下载附件6下载文档',
  `days` int(11) NOT NULL DEFAULT '0' COMMENT '天数涉及查看付费内容|下载附件|下载文档',
  `nums` int(11) NOT NULL DEFAULT '0' COMMENT '次数涉及下载附件|下载文档',
  `bili` int(11) NOT NULL DEFAULT '0' COMMENT '比例涉及付费内容|下载附件|下载文档',
  `limittime` varchar(255) NOT NULL DEFAULT '0' COMMENT '时间涉及发帖|发文档|回帖|下载',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '等级图标id',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员等级表';
INSERT INTO `5isns_usergrade` VALUES ('2', '普通会员', '0', '2', '1,2,3,4', '0', '0', '100', '0,0,0,0', '0', '1', '1556592145', '0');


DROP TABLE IF EXISTS `5isns_chongzhi`;
CREATE TABLE IF NOT EXISTS `5isns_chongzhi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `score` int(10) NOT NULL,
  `rmb` int(10) NOT NULL,
  `errorcode` varchar(200) DEFAULT NULL COMMENT '错误代码',
  `trade_no` varchar(200) DEFAULT NULL COMMENT '单号',
  `out_trade_no` varchar(200) DEFAULT NULL COMMENT '商户单号',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1支付宝',
  `actiontype` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1充值2打赏',
  `itemid` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1成功',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
)ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户充值表';

DROP TABLE IF EXISTS `5isns_raty_user`;
CREATE TABLE `5isns_raty_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `score` int(10) NOT NULL,
  `itemid` int(11) NOT NULL COMMENT '文档id',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

    
DROP TABLE IF EXISTS `5isns_menu`;
CREATE TABLE `5isns_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '模块',
  `controller` char(255) NOT NULL DEFAULT '' COMMENT 'controller',
  `action` char(255) NOT NULL DEFAULT '' COMMENT 'action',
  `is_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `icon` char(30) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10240 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of 5isns_menu
-- ----------------------------

INSERT INTO `5isns_menu` VALUES ('1', '系统管理', '0', '10', 'system', '', '', '0', 'fa-wrench', '1', '1491578008', '9');
INSERT INTO `5isns_menu` VALUES ('2', '用户管理', '0', '9', 'users', '', '', '0', 'fa-group', '1', '1491578008', '9');
INSERT INTO `5isns_menu` VALUES ('5', '帖子管理', '0', '7', 'topics', '', '', '0', 'fa-file-text-o', '1', '1491578008', '9');
INSERT INTO `5isns_menu` VALUES ('6', '文档管理', '0', '7', 'docs', '', '', '0', 'fa-file-word-o', '1', '1491578008', '9');
INSERT INTO `5isns_menu` VALUES ('7', '记录管理', '0', '6', 'records', '', '', '0', 'fa-bar-chart', '1', '1491578008', '9');
INSERT INTO `5isns_menu` VALUES ('8', '前台设置', '0', '8', 'front', '', '', '0', 'fa-laptop', '1', '1491578008', '9');


INSERT INTO `5isns_menu` VALUES ('801', '话题列表', '8', '5', 'front', 'topiccate', 'list', '0', 'fa-th-large', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('8011', '话题编辑', '801', '0', 'front', 'topiccate', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('8012', '话题删除', '801', '0', 'front', 'topiccate', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('8013', '话题添加', '801', '0', 'front', 'topiccate', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('8014', '话题批量删除', '801', '0', 'front', 'topiccate', 'alldel', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('8015', '话题状态更新', '801', '3', 'front', 'topiccate', 'cstatus', '1', '', '1', '1491837214', '0');



INSERT INTO `5isns_menu` VALUES ('802', '前台导航', '8', '4', 'front', 'nav', 'list', '0', 'fa-hand-o-right', '1', '1491668183', '0');
INSERT INTO `5isns_menu` VALUES ('8021', '导航添加', '802', '3', 'front', 'nav', 'add', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('8022', '导航编辑', '802', '3', 'front', 'nav', 'edit', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('8023', '导航批量删除', '802', '3', 'front', 'nav', 'alldel', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('8024', '导航删除', '802', '3', 'front', 'nav', 'del', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('8025', '导航状态更新', '802', '3', 'front', 'nav', 'cstatus', '1', '', '1', '1491837214', '0');

INSERT INTO `5isns_menu` VALUES ('501', '帖子列表', '5', '5', 'topics', 'topic', 'list', '0', 'fa-file-o', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('5011', '帖子编辑', '501', '0', 'topics', 'topic', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('5012', '帖子删除', '501', '0', 'topics', 'topic', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('5013', '帖子添加', '501', '0', 'topics', 'topic', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('5014', '帖子批量删除', '501', '0', 'topics', 'topic', 'alldel', '1', '', '1', '1491674201', '0');

INSERT INTO `5isns_menu` VALUES ('502', '帖子评论', '5', '5', 'topics', 'topic_comment', 'list', '0', 'fa-comments', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('5021', '评论编辑', '502', '0', 'topics', 'topic_comment', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('5022', '评论删除', '502', '0', 'topics', 'topic_comment', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('5023', '评论添加', '502', '0', 'topics', 'topic_comment', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('5024', '评论批量删除', '502', '0', 'topics', 'topic_comment', 'alldel', '1', '', '1', '1491674201', '0');

INSERT INTO `5isns_menu` VALUES ('601', '文档列表', '6', '5', 'docs', 'doc', 'list', '0', 'fa-file-o', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('6011', '文档编辑', '601', '0', 'docs', 'doc', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('6012', '文档删除', '601', '0', 'docs', 'doc', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('6013', '文档添加', '601', '0', 'docs', 'doc', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('6014', '文档批量删除', '601', '0', 'docs', 'doc', 'alldel', '1', '', '1', '1491674201', '0');

INSERT INTO `5isns_menu` VALUES ('602', '文档评论', '6', '5', 'docs', 'doc_comment', 'list', '0', 'fa-comments', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('6021', '评论编辑', '602', '0', 'docs', 'doc_comment', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('6022', '评论删除', '602', '0', 'docs', 'doc_comment', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('6023', '评论添加', '602', '0', 'docs', 'doc_comment', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('6024', '评论批量删除', '602', '0', 'docs', 'doc_comment', 'alldel', '1', '', '1', '1491674201', '0');


INSERT INTO `5isns_menu` VALUES ('101', '菜单列表', '1', '5', 'system', 'menu', 'list', '0', 'fa-align-justify', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1011', '菜单编辑', '101', '0', 'system', 'menu', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('1012', '菜单删除', '101', '0', 'system', 'menu', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('1013', '菜单添加', '101', '0', 'system', 'menu', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('1014', '菜单批量删除', '101', '0', 'system', 'menu', 'alldel', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('1015', '菜单状态更新', '101', '3', 'system', 'menu', 'cstatus', '1', '', '1', '1491837214', '0');


INSERT INTO `5isns_menu` VALUES ('102', '系统配置', '1', '6', 'system', 'config', 'setting', '0', 'fa-cogs', '1', '1491668183', '0');
INSERT INTO `5isns_menu` VALUES ('103', '清理缓存', '1', '0', 'system', 'sys', 'cache', '0', 'fa-sign-language', '1', '1491668183', '0');

INSERT INTO `5isns_menu` VALUES ('104', '回收站', '1', '2', 'system', 'trash', 'list', '0', 'fa-recycle', '1', '1492320214', '1492311462');
INSERT INTO `5isns_menu` VALUES ('1041', '数据列表', '104', '1', 'system', 'trash', 'datalist', '1', '', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1042', '数据删除', '104', '1', 'system', 'trash', 'datadel', '1', '', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1043', '数据恢复', '104', '1', 'system', 'trash', 'restoredata', '1', '', '1', '1491318724', '0');


INSERT INTO `5isns_menu` VALUES ('105', '备份数据', '1', '1', 'system', 'database', 'list', '0', 'fa-inbox', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1051', '备份数据', '105', '1', 'system', 'database', 'export', '1', '', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1052', '优化表', '105', '1', 'system', 'database', 'optimize', '1', '', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1053', '修复表', '105', '1', 'system', 'database', 'repair', '1', '', '1', '1491318724', '0');

INSERT INTO `5isns_menu` VALUES ('106', '还原数据', '1', '0', 'system', 'database', 'importlist', '0', 'fa-undo', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1061', '还原数据库', '106', '0', 'system', 'database', 'import', '1', '', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1062', '删除数据库', '106', '0', 'system', 'database', 'delete', '1', '', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1063', '下载备份', '106', '0', 'system', 'database', 'download', '1', '', '1', '1491318724', '0');

INSERT INTO `5isns_menu` VALUES ('107', '积分规则', '1', '5', 'system', 'pointrule', 'list', '0', 'fa-align-justify', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('1071', '规则编辑', '107', '0', 'system', 'pointrule', 'edit', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('1072', '规则删除', '107', '0', 'system', 'pointrule', 'del', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('1073', '规则添加', '107', '0', 'system', 'pointrule', 'add', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('1074', '规则批量删除', '107', '0', 'system', 'pointrule', 'alldel', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('1075', '规则状态更新', '107', '3', 'system', 'pointrule', 'cstatus', '1', '', '1', '1491837214', '0');


INSERT INTO `5isns_menu` VALUES ('201', '会员列表', '2', '3', 'users', 'user', 'list', '0', 'fa-user', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2011', '会员添加', '201', '3', 'users', 'user', 'add', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2012', '会员编辑', '201', '3', 'users', 'user', 'edit', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2013', '会员批量删除', '201', '3', 'users', 'user', 'alldel', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2014', '会员删除', '201', '3', 'users', 'user', 'del', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2015', '会员授权', '201', '3', 'users', 'user', 'auth', '1', '', '1', '1491837214', '0');

INSERT INTO `5isns_menu` VALUES ('202', '会员等级', '2', '2', 'users', 'usergrade', 'list', '0', 'fa-signal', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2021', '会员等级添加', '202', '3', 'users', 'usergrade', 'add', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2022', '会员等级编辑', '202', '3', 'users', 'usergrade', 'edit', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2023', '会员等级批量删除', '202', '3', 'users', 'usergrade', 'alldel', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2024', '会员等级删除', '202', '3', 'users', 'usergrade', 'del', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('2025', '会员等级授权', '202', '3', 'users', 'usergrade', 'auth', '1', '', '1', '1491837214', '0');



INSERT INTO `5isns_menu` VALUES ('204', '会员审核', '2', '1', 'users', 'rzuser', 'list', '0', 'fa-id-card', '1', '1492000451', '0');
INSERT INTO `5isns_menu` VALUES ('2041', '认证审核', '204', '3', 'users', 'rzuser', 'cstatus', '1', '', '1', '1491837214', '0');

INSERT INTO `5isns_menu` VALUES ('701', '积分记录', '7', '3', 'records', 'pointnote', 'list', '0', 'fa-database', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7011', '记录添加', '701', '3', 'records', 'pointnote', 'add', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7012', '记录编辑', '701', '3', 'records', 'pointnote', 'edit', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7013', '记录批量删除', '701', '3', 'records', 'pointnote', 'alldel', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7014', '记录删除', '701', '3', 'records', 'pointnote', 'del', '1', '', '1', '1491837214', '0');


INSERT INTO `5isns_menu` VALUES ('702', '消息记录', '7', '2', 'records', 'message', 'list', '0', 'fa-volume-up', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('7021', '消息添加', '702', '3', 'records', 'message', 'add', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7022', '消息编辑', '702', '3', 'records', 'message', 'edit', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7023', '消息批量删除', '702', '3', 'records', 'message', 'alldel', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7024', '消息删除', '702', '3', 'records', 'message', 'del', '1', '', '1', '1491837214', '0');

INSERT INTO `5isns_menu` VALUES ('703', '举报记录', '7', '2', 'records', 'jubao', 'list', '0', 'fa-volume-up', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('7031', '举报批量删除', '703', '3', 'records', 'jubao', 'alldel', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7032', '举报删除', '703', '3', 'records', 'jubao', 'del', '1', '', '1', '1491837214', '0');

INSERT INTO `5isns_menu` VALUES ('704', '提现记录', '7', '3', 'records', 'tixian', 'list', '0', 'fa-database', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7041', '提现通过', '704', '3', 'records', 'tixian', 'cstatus', '1', '', '1', '1491837214', '0');
INSERT INTO `5isns_menu` VALUES ('7042', '删除申请', '704', '3', 'records', 'tixian', 'del', '1', '', '1', '1491837214', '0');



INSERT INTO `5isns_menu` VALUES ('4', '扩展管理', '0', '7', 'expand', '', '', '0', 'fa-linode', '1', '1491578008', '9');
INSERT INTO `5isns_menu` VALUES ('401', '插件列表', '4', '5', 'expand', 'plugins', 'list', '0', 'fa-file-o', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('4011', '插件安装', '401', '0', 'expand', 'plugins', 'install', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('4012', '插件卸载', '401', '0', 'expand', 'plugins', 'uninstall', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('4013', '插件禁用', '401', '0', 'expand', 'plugins', 'forbidden', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('4014', '插件配置', '401', '0', 'expand', 'plugins', 'config', '1', '', '1', '1491666947', '0');
INSERT INTO `5isns_menu` VALUES ('4015', '插件数据', '401', '0', 'expand', 'plugins', 'manage', '1', '', '1', '1491666947', '0');

INSERT INTO `5isns_menu` VALUES ('402', '模块列表', '4', '5', 'expand', 'modules', 'list', '0', 'fa-file-o', '1', '1491318724', '0');
INSERT INTO `5isns_menu` VALUES ('4021', '模块安装', '402', '0', 'expand', 'modules', 'install', '1', '', '1', '1491674180', '0');
INSERT INTO `5isns_menu` VALUES ('4022', '模块卸载', '402', '0', 'expand', 'modules', 'uninstall', '1', '', '1', '1491674201', '0');
INSERT INTO `5isns_menu` VALUES ('4023', '模块禁用', '402', '0', 'expand', 'modules', 'forbidden', '1', '', '1', '1491666947', '0');


DROP TABLE IF EXISTS `5isns_nav`;
CREATE TABLE `5isns_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` tinyint(3) unsigned NOT NULL COMMENT '顶部还是底部',
  `name` varchar(20) NOT NULL COMMENT '导航名称',
  `alias` varchar(20) DEFAULT '' COMMENT '导航别称',
  `link` varchar(255) DEFAULT '' COMMENT '导航链接',
  `icon` varchar(255) DEFAULT '' COMMENT '导航图标',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='导航表';
INSERT INTO `5isns_nav` (id, pid, name,alias,link,target) VALUES (1, 1, '文章', 'thread', 'thread-list', '_self');
INSERT INTO `5isns_nav` (id, pid, name,alias,link,target) VALUES (2, 1, '文档', 'doc', 'doc-list', '_self');
INSERT INTO `5isns_nav` (id, pid, name,alias,link,target) VALUES (3, 1, '话题', 'tags', 'tags-taglist', '_self');




DROP TABLE IF EXISTS `5isns_point_rule`;
CREATE TABLE IF NOT EXISTS `5isns_point_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `controller` varchar(30) NOT NULL DEFAULT '' COMMENT '规则名称',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为增加2为减少',
  `score` varchar(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `num` varchar(11) NOT NULL DEFAULT '0' COMMENT '二十四小时奖赏次数',
  `tasknum` varchar(11) NOT NULL DEFAULT '0' COMMENT '奖赏次数',
  `scoretype` varchar(30) NOT NULL DEFAULT '' COMMENT '积分类型',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='积分规则表';

DROP TABLE IF EXISTS `5isns_point_note`;
CREATE TABLE `5isns_point_note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,  
  `uid` int(10) unsigned NOT NULL,
  `inctype` char(1) NOT NULL DEFAULT '+',
  `score` int(10) NOT NULL,
  `itemid` varchar(11) NOT NULL DEFAULT '0' COMMENT '表示帖子或者其他各种类型的主键id',
  `to_uid` varchar(11) NOT NULL DEFAULT '0' COMMENT '规则id或者受益人uid',
  `scoretype` varchar(30) NOT NULL DEFAULT '' COMMENT '积分类型',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1下载附件2下载文档3付费阅读4充值5购买会员6打赏7提现8积分规则',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  `description` varchar(200) NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `5isns_doccon`;
CREATE TABLE IF NOT EXISTS `5isns_doccon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `choice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '精品',
  `settop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '顶置',
  `praise` int(11) NOT NULL DEFAULT '0' COMMENT '赞',
  `view` int(11) NOT NULL DEFAULT '0' COMMENT '浏览量',
  `sc` int(11) NOT NULL DEFAULT '0' COMMENT '收藏量',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `down` int(11) NOT NULL DEFAULT '0' COMMENT '下载量',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `reply` int(11) NOT NULL DEFAULT '0' COMMENT '回复',
  `keywords` varchar(100) NOT NULL COMMENT '关键词',
  `description` varchar(200) NOT NULL COMMENT '描述',
  `fileid` varchar(11) NOT NULL DEFAULT '0' COMMENT '文件id',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `pageid` int(11) NOT NULL DEFAULT '0' COMMENT '页数',
  `showpage` int(11) NOT NULL DEFAULT '2' COMMENT '默认显示页数',
  `raty` varchar(11) NOT NULL DEFAULT '0' COMMENT '评分',
  `ctype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '转换类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `5isns_topiccate`;
CREATE TABLE IF NOT EXISTS `5isns_topiccate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '话题ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '话题名称',
  `gradeid` varchar(255) NOT NULL DEFAULT '' COMMENT '限制发布的用户组',
  `choice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐话题',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '话题描述',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题图片id',
  `characters` varchar(10) NOT NULL COMMENT '所属字母',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `doc_num` int(11) NOT NULL DEFAULT '0' COMMENT '文档数量',
  `topic_num` int(11) NOT NULL DEFAULT '0' COMMENT '帖子数量',
  `user_num` int(11) NOT NULL DEFAULT '0' COMMENT '关注数量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='话题表';


DROP TABLE IF EXISTS `5isns_topic`;
CREATE TABLE IF NOT EXISTS `5isns_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1单页2帖子',
  `free` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0免费1付费2部分收费',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '付费积分',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `choice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '精贴',
  `settop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '顶置',
  `sc` int(11) NOT NULL DEFAULT '0' COMMENT '收藏',
  `view` int(11) NOT NULL DEFAULT '0' COMMENT '浏览量',
  `img_num` int(11) NOT NULL DEFAULT '0' COMMENT '图片数量',
  `file_num` int(11) NOT NULL DEFAULT '0' COMMENT '附件数量',
  `filelist` text DEFAULT NULL COMMENT '附件列表',
  `first_img` varchar(100) DEFAULT NULL  COMMENT '首图片',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `reply` int(11) NOT NULL DEFAULT '0' COMMENT '回复',
  `keywords` varchar(200) DEFAULT NULL  COMMENT '关键词',
  `description` varchar(200) DEFAULT NULL  COMMENT '描述',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `5isns_comment`;
CREATE TABLE IF NOT EXISTS `5isns_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '上级评论',
  `uid` int(11) NOT NULL COMMENT '所属会员',
  `fid` int(11) NOT NULL COMMENT '所属帖子',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1帖子2文档',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `ding` int(11) DEFAULT '0' COMMENT '赞',
  `reply` int(11) DEFAULT '0' COMMENT '回复',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='评论表';

DROP TABLE IF EXISTS `5isns_jubao`;
CREATE TABLE IF NOT EXISTS `5isns_jubao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '所属会员',
  `fid` int(11) NOT NULL COMMENT '帖子文档用户',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0用户1帖子2文档',
  `reason` tinyint(1) NOT NULL DEFAULT '1' COMMENT '原因',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='举报表';

DROP TABLE IF EXISTS `5isns_message`;
CREATE TABLE IF NOT EXISTS `5isns_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '所属会员',
  `touid` int(11) NOT NULL DEFAULT '0' COMMENT '发送对象',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1系统消息2私信',
  `content` text NOT NULL COMMENT '内容',
  `id_to_id` varchar(100) NOT NULL COMMENT '对话',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态2表示已读',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='消息表';


DROP TABLE IF EXISTS `5isns_searchword`;
CREATE TABLE IF NOT EXISTS `5isns_searchword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '热搜关键词',
  `uid` int(10) NOT NULL,
  `num` int(20) NOT NULL DEFAULT '1' COMMENT '搜索次数',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户热搜表';



DROP TABLE IF EXISTS `5isns_tagsandother`;
CREATE TABLE `5isns_tagsandother` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '话题名称',
  `tid` int(11) NOT NULL COMMENT '话题id',
  `did` int(11) NOT NULL COMMENT '管理目标id',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '关联目标类型0用户1帖子2文档',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `5isns_usersandother`;
CREATE TABLE `5isns_usersandother` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '名称',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `did` int(11) NOT NULL COMMENT '管理目标id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '关联目标类型0用户1帖子2话题3文档4消息5评论点赞',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS 5isns_session;
CREATE TABLE 5isns_session (
  sid char(32) NOT NULL default '0',			# 随机生成 id 不能重复 uniqueid() 13 位
  uid int(11) unsigned NOT NULL default '0',		# 用户id 未登录为 0，可以重复
  fid tinyint(3) unsigned NOT NULL default '0',		# 所在的版块
  url char(32) NOT NULL default '',			# 当前访问 url
  ip int(11) unsigned NOT NULL default '0',		# 用户ip
  useragent char(128) NOT NULL default '',		# 用户浏览器信息
  data char(255) NOT NULL default '',			# session 数据，超大数据存入大表。
  bigdata tinyint(1) NOT NULL default '0',		# 是否有大数据。
  last_date int(11) unsigned NOT NULL default '0',	# 上次活动时间
  PRIMARY KEY (sid),
  KEY ip (ip),
  KEY fid (fid),
  KEY uid_last_date (uid, last_date)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


DROP TABLE IF EXISTS 5isns_session_data;
CREATE TABLE 5isns_session_data (
  sid char(32) NOT NULL default '0',			#
  last_date int(11) unsigned NOT NULL default '0',	# 上次活动时间
  data text NOT NULL,					# 存超大数据
  PRIMARY KEY (sid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


# 持久的 key value 数据存储, ttserver, mysql
DROP TABLE IF EXISTS 5isns_kv;
CREATE TABLE 5isns_kv (
  k char(32) NOT NULL default '',
  v mediumtext NOT NULL,
  expiry int(11) unsigned NOT NULL default '0',		# 过期时间
  PRIMARY KEY(k)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

# 缓存表，用来保存临时数据。
DROP TABLE IF EXISTS 5isns_cache;
CREATE TABLE 5isns_cache (
  k char(32) NOT NULL default '',
  v mediumtext NOT NULL,
  expiry int(11) unsigned NOT NULL default '0',		# 过期时间
  PRIMARY KEY(k)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

# 临时队列，用来保存临时数据。
DROP TABLE IF EXISTS 5isns_queue;
CREATE TABLE 5isns_queue (
  queueid int(11) unsigned NOT NULL default '0',		# 队列 id
  v int(11) NOT NULL default '0',			# 队列中存放的数据，只能为 int
  expiry int(11) unsigned NOT NULL default '0',		# 过期时间，默认 0，不过期
  UNIQUE KEY(queueid, v),
  KEY(expiry)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


