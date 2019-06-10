<?php
!defined('DEBUG') and exit('Access Denied.');

define('BIND_MODULE','admin');
define('ADMIN_PATH', APP_PATH.BIND_MODULE.'/');

include MODEL_PATH.'model.php';
include MODEL_PATH.'admin.func.php';
include APP_PATH.BIND_MODULE.'/route.php';




?>