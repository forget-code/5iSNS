<?php

!defined('DEBUG') AND define('DEBUG', 1);

define("WWWROOT",str_replace("\\","/",dirname(__FILE__)));
define('APP_PATH', WWWROOT.'/app/');
if(file_exists(WWWROOT.'/data/config/db.php')){
$conf = (@include WWWROOT.'/data/config/conf.default.php');
$conf_db = include WWWROOT.'/data/config/db.php';
$conf = array_merge($conf,$conf_db);
$conf['base_web_url'] = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME']));
include WWWROOT.'/basephp/base.php';

$module = param(0);

define('MODEL_PATH', APP_PATH.$module.'/model/');
include APP_PATH.$module.'/index.php';
}else{

exit('<script>window.location="/install/"</script>');
}



?>