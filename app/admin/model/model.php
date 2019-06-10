<?php

!defined('DEBUG') AND exit('Forbidden');

// 可以合并成一个文件，加快速度

$include_model_files = array (
	PUBLIC_MODEL_PATH.'attach.model.php',    
	PUBLIC_MODEL_PATH.'form.model.php',
	PUBLIC_MODEL_PATH.'check.model.php',
	PUBLIC_MODEL_PATH.'misc.model.php',
 	PUBLIC_MODEL_PATH.'queue.model.php',   
	PUBLIC_MODEL_PATH.'kv.model.php',

	PUBLIC_MODEL_PATH.'session.model.php',
	PUBLIC_MODEL_PATH.'menu.model.php',
    PUBLIC_MODEL_PATH.'user.model.php',
	PUBLIC_MODEL_PATH.'topiccate.model.php',
    PUBLIC_MODEL_PATH.'topic.model.php',
    PUBLIC_MODEL_PATH.'doc.model.php',
    PUBLIC_MODEL_PATH.'nav.model.php',
    PUBLIC_MODEL_PATH.'pointnote.model.php',

	
);


if(DEBUG) {
	foreach ($include_model_files as $model_files) {
		include $model_files;
	}
} else {
	
	$model_min_file = $conf['tmp_path'].'admin.model.min.php';
	$isfile = is_file($model_min_file);
	if(!$isfile) {
		$s = '';
		foreach($include_model_files as $model_files) {
			
			// 压缩后不利于调试，有时候碰到未结束的 php 标签，会暴 500 错误
			//$s .= php_strip_whitespace(_include($model_files));

			$t = file_get_contents($model_files);
			$t = trim($t);
			$t = ltrim($t, '<?php');
			$t = rtrim($t, '?>');
			$s .= "<?php\r\n".$t."\r\n?>";
            
		}
		
		
		$r = file_put_contents($model_min_file, $s);
		unset($s);
	}
	include $model_min_file;
}


$conf_self = include APP_PATH.BIND_MODULE.'/conf.php';
$conf = array_merge($conf,$conf_self);

?>