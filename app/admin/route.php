<?php

!defined('DEBUG') AND exit('Access Denied.');

!isset($_SESSION) AND $sid = sess_start();



if(DEBUG < 3) {

	// 管理员令牌检查 / check admin token
	admin_token_check();
}

$route = param(1, 'index');

$uid = intval(_SESSION('uid'));
empty($uid) AND $uid = user_token_get() AND $_SESSION['uid'] = $uid;

$user = user_read($uid);


$header = array(
	'title'=>'5iSNS实验室后台管理',
	'keywords'=>'', 
	'description'=>strip_tags($conf['sitebrief'])
);

if(!defined('SKIP_ROUTE')) {
	$action = param(2,'');
	is_numeric($action) AND $action = '';
	
	if(is_file(ADMIN_PATH.'controller/'.$route.'.php')){

        include ADMIN_PATH.'controller/'.$route.'.php';
	}else{
		include PUBLIC_CON_PATH.$route.'.php';
	}
	

}



?>