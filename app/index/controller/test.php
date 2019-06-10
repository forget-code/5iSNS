<?php

!defined('DEBUG') AND exit('Access Denied.');


$urlarr = array('sdfs');

$ch = curl_init();
    $options =  array(
    CURLOPT_URL => 'http://data.zz.baidu.com/urls?site=1bbs.5isns.com&token=WPJgk4iS893tTA2y',
    CURLOPT_POST => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POSTFIELDS => implode("\n", $urlarr),
    CURLOPT_HTTPHEADER => array('Content-Type: text/plain'),
    );
    curl_setopt_array($ch, $options);
    $res = curl_exec($ch);
    dump(json_decode($res,true));