<?php

!defined('DEBUG') AND exit('Access Denied.');



if (empty($action) || $action == 'list') {

    $page       = param('page', 1);
   
    
    $where = array('status' => 1);


    $pagenum    = $conf['pagesize'];
    $pointnotelist   = db_find('point_note',$where, '', $page, $pagenum);
    $totalnum   = db_count('point_note',$where);
    $pagination = pagination(r_url('pointnote-list', array('page' => 'pagenum')), $totalnum, $page, $pagenum);
    include ADMIN_PATH . "view/pointnote_list.html";

}



?>
