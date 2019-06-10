<?php
!defined('DEBUG') and exit('Access Denied.');
define('BIND_MODULE','index');
define('INDEX_PATH', APP_PATH.'index/');

include MODEL_PATH.'model.php';
include APP_PATH.BIND_MODULE.'/route.php';




?>