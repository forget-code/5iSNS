<?php

!defined('DEBUG') AND exit('Access Denied.');






if(empty($action)) {

	$info = array();
	$info['disable_functions'] = ini_get('disable_functions');
	$info['allow_url_fopen'] = ini_get('allow_url_fopen') ? '是' : '否';
	$info['safe_mode'] = ini_get('safe_mode') ? '是' : '否';
	empty($info['disable_functions']) && $info['disable_functions'] = '无';
	$info['upload_max_filesize'] = ini_get('upload_max_filesize');
	$info['post_max_size'] = ini_get('post_max_size');
	$info['memory_limit'] = ini_get('memory_limit');
	$info['max_execution_time'] = ini_get('max_execution_time');
	$info['dbversion'] = $db->version();
	$info['SERVER_SOFTWARE'] = _SERVER('SERVER_SOFTWARE');
	$info['HTTP_X_FORWARDED_FOR'] = _SERVER('HTTP_X_FORWARDED_FOR');
	$info['REMOTE_ADDR'] = _SERVER('REMOTE_ADDR');


	$stat = array();
    $stat['docs'] = 0;
    $stat['topics'] = 0;
	$stat['users'] = user_count();
	$stat['attachs'] = file_count();
	$stat['disk_free_space'] = function_exists('disk_free_space') ? humansize(disk_free_space(ROOT_PATH)) : '未知';

	//$lastversion = get_last_version($stat);
        
	include ADMIN_PATH.'view/home.html';
	
} elseif($action == 'cache') {
if($method == 'GET') {
	
		
		$input = array();
		$input['clear_tmp'] = form_checkbox('clear_tmp', 1);
		$input['clear_cache'] = form_checkbox('clear_cache', 1);
		include ADMIN_PATH.'view/clear_cache.html';
		
	} else {
		
		$clear_tmp = param('clear_tmp');
		$clear_cache = param('clear_cache');
		
		$clear_cache AND cache_truncate();
		$clear_cache AND $runtime = NULL; // 清空
		
		$clear_tmp AND rmdir_recusive($conf['tmp_path'], 1);

		message(0, '缓存清理成功');
	}
	
} elseif($action == 'login') {


} else {
	
}

function get_last_version($stat) {
	global $conf, $time;
	$last_version = kv_get('last_version');
	if($time - $last_version > 86400) {
		kv_set('last_version', $time);
		$sitename = urlencode($conf['sitename']);
		$sitedomain = urlencode(http_url_path());
		$version = urlencode($conf['version']);
		return '<script src="http://custom.5isns.com/version.htm?sitename='.$sitename.'&sitedomain='.$sitedomain.'&users='.$stat['users'].'&threads='.$stat['threads'].'&posts='.$stat['posts'].'&version='.$version.'"></script>';
	} else {
		return '';
	}
}

?>
