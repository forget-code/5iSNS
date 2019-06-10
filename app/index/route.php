<?php

!defined('DEBUG') AND exit('Access Denied.');

!isset($_SESSION) AND $sid = sess_start();

$uid = intval(_SESSION('uid'));
empty($uid) AND $uid = user_token_get() AND $_SESSION['uid'] = $uid;

$user = user_read($uid);

if($uid>0){
	$user = up_usergrade($user);
	
	$userqx = user_qx_cache($uid);
	
}


$nav_top_all = nav_top();//头部导航

$nav_top_count = count($nav_top_all);

if($nav_top_count>3){
   $nav_top = array_slice($nav_top_all,0,3);
   array_splice($nav_top_all,0,3);
   $nav_top_end = $nav_top_all;
	
}else{
	$nav_top = $nav_top_all;
}

$nav_bottom = nav_bottom();

// 头部 header.inc.htm 
$header = array(
	'title'=>$conf['sitename'],
	'keywords'=>'', // 搜索引擎自行分析 keywords, 自己指定没用
	'description'=>strip_tags($conf['sitebrief']),
);

$plugin->run('spider','getspider');

$route = param(1, 'index');

if(!defined('SKIP_ROUTE')) {
	$action = param(2);
	is_numeric($action) AND $action = '';

	if(is_file(INDEX_PATH.'controller/'.$route.'.php')){
        include INDEX_PATH.'controller/'.$route.'.php';
	}else{
		include PUBLIC_CON_PATH.$route.'.php';
	}
	

}




?>