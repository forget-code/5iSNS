<?php
return array (
  'cache' => 
  array (
    'enable' => true,
    'type' => 'mysql',
    'memcached' => 
    array (
      'host' => 'localhost',
      'port' => '11211',
      'cachepre' => '5isns_',
    ),
    'redis' => 
    array (
      'host' => 'localhost',
      'port' => '6379',
      'cachepre' => '5isns_',
    ),
    'xcache' => 
    array (
      'cachepre' => '5isns_',
    ),
    'yac' => 
    array (
      'cachepre' => '5isns_',
    ),
    'apc' => 
    array (
      'cachepre' => '5isns_',
    ),
    'mysql' => 
    array (
      'cachepre' => '5isns_',
    ),
  ),
  'batabase_export_config' => 
  array (
    'path' => './data/database/',
    'DATA_BACKUP_PART_SIZE' => 20971520,
    'DATA_BACKUP_COMPRESS' => 1,
    'DATA_BACKUP_COMPRESS_LEVEL' => 9,
  ),
  'trashlist' => 
  array (
    'menu' => 
    array (
      0 => '菜单',
      1 => 'name',
      2 => 'id',
    ),
    'topiccate' => 
    array (
      0 => '话题',
      1 => 'name',
      2 => 'id',
    ),
    'topic' => 
    array (
      0 => '帖子',
      1 => 'title',
      2 => 'id',
    ),
    'doccon' => 
    array (
      0 => '文档',
      1 => 'title',
      2 => 'id',
    ),
    'comment' => 
    array (
      0 => '评论',
      1 => 'content',
      2 => 'id',
    ),
    'user' => 
    array (
      0 => '用户',
      1 => 'nickname',
      2 => 'id',
    ),
    'usergrade' => 
    array (
      0 => '会员等级',
      1 => 'name',
      2 => 'id',
    ),
  ),
  'pointname' => 
  array (
    'point' => '财富值',
    'expoint1' => '经验',
    'expoint2' => '扩展积分2',
    'expoint3' => '扩展积分3',
  ),
  'pointrule' => 
  array (
    'yaoqing' => '邀请注册',
    'login' => '登录',
    'docadd' => '发布文档',
    'docdelete' => '文档被删除',
    'bindmobile' => '绑定手机',
    'bindmail' => '绑定邮箱',
    'topicadd' => '发布文章',
    'topicdelete' => '文章被删除',
    'commentadd' => '发布评论',
    'commentdelete' => '评论被删除',
  ),
  'tmp_path' => './data/tmp/',
  'log_path' => './data/log/',
  'view_url' => 'view/',
  'upload_url' => 'upload/',
  'upload_path' => './upload/',
  'sitename' => '5iSNS内容付费系统',
  'web_url' => 'http://www.5isns.com',
  'api_url' => 'http://api.imzaker.com:80',
  'beinum' => '',
  'shuiyin' => '5iSNS实验室',
  'sy_type' => 1,
  'sitebrief' => '知识付费意味着人们对高质量知识内容的渴求，也是对知识的尊重，有迫切需要的人自然会乐于付费。社交网络开始服务知识付费是大势所趋。在互联网惯性下，内容、社交、付费，三者合一，站长将在此基础上享受更多红利。',
  'timezone' => 'Asia/Shanghai',
  'runlevel' => 5,
  'runlevel_reason' => 'The site is under maintenance, please visit later.',
  'postlist_pagesize' => 100,
  'cache_thread_list_pages' => 10,
  'session_delay_update' => 0,//session延迟更新
  'upload_image_width' => 927,
  'admin_bind_ip' => 0,
  'update_views_on' => 1,//是否更新帖子和文档的阅读量
  'no_img_index'=>0,
  'cookie_domain' => '',
  'cookie_path' => '',
  'online_hold_time' => 3600,// 活动时间
  'allow_cate_show' => 20,
  'choose_cate_num' => 2,
  'pagesize' => 10,
  'user_create_email_on' => 0,
  'user_create_on' => 1,
  'user_resetpw_on' => 1,
  'url_rewrite_on' => 0,
  'index_theme_name' => 'default',
  'version' => '1.0.7',
  'static_version' => '?1.0',
  'cdn_use' => 0,
  'online_trans' => 0,
  'appid' => '1',
  'module_arr' => 
  array (
    0 => 'index',
    1 => 'admin',
  ),
  'chongzhi' => 
  array (
    'bili' => 10,
  ),
  'tixian' => 
  array (
    'bili' => 10,
  ),
  'alipay' => 
  array (
    'app_id' => '',
    'public_key' => '',
    'private_key' => '',
  ),
  'paymethod' => 1,
  'wechat' => 
  array (
    'mch_id' => '',
    'app_id' => '',
    'mch_key' => '',
  ),
);
?>