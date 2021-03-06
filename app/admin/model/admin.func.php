<?php

define('XN_ADMIN_BIND_IP', array_value($conf, 'admin_bind_ip'));
function get_trash_number($name){
    return db_count($name,array('status'=>-1));
}
function admin_token_check() {
	global $longip, $time, $useragent, $conf;
	$useragent_md5 = md5($useragent);
	

	$key = md5((XN_ADMIN_BIND_IP ? $longip : '').$useragent_md5.xn_key());

	
	$admin_token = param('5isns_admin_token');
	
	if(empty($admin_token)) {
		
		$_REQUEST[1] = 'index';
		$_REQUEST[2] = 'login';
	} else {
		$s = xn_decrypt($admin_token, $key);
		if(empty($s)) {
			setcookie('5isns_admin_token', '', 0, '', '', '', TRUE);
			
			message(-1, '管理登陆令牌失效，请重新登录');
		}
		list($_ip, $_time) = explode("\t", $s);
		
		// 后台超过 3600 自动退出。
		// Background / more than 3600 automatic withdrawal.
		//if($_ip != $longip || $time - $_time > 3600) {
		if((XN_ADMIN_BIND_IP && $_ip != $longip || !XN_ADMIN_BIND_IP) && $time - $_time > 3600) {

			setcookie('5isns_admin_token', '', 0, '', '', '', TRUE);
			message(-1, '管理登陆令牌失效，请重新登录');
		}
		
		// 超过半小时，重新发新令牌，防止过期
		// More than half an hour, reset a new token, prevent expired
		if($time - $_time > 1800) {
			admin_token_set();
		}
	}
	
}

function admin_token_set() {
	global $longip, $time, $useragent, $conf;
	$useragent_md5 = md5($useragent);

	$key = md5((XN_ADMIN_BIND_IP ? $longip : '').$useragent_md5.xn_key());

	
	//$admin_token = param('5isns_admin_token');
	$s = "$longip	$time";
	
	$admin_token = xn_encrypt($s, $key);

	setcookie('5isns_admin_token', $admin_token, $time + 3600, '',  '', 0, TRUE);

}

function admin_token_clean() {
	global $time;
	setcookie('5isns_admin_token', '', $time - 86400, '', '', 0, TRUE);

}


function admin_tab_active($arr, $active) {
	
	$s = '';
	
	foreach ($arr as $k=>$v) {
		$s .= '<li class="'.($active == $k ? ' active' : '').'" ><a  href="'.$v['url'].'">'.$v['text'].'</a></li>';
	}
	
	return $s;
}


?>