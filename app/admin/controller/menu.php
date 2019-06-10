<?php
/**
 * @authors 5iSNS实验室 (admin@5isns.com)
 * @date    2019-03-30 18:27:46
 * @version 1.0.0
 */
!defined('DEBUG') and exit('Access Denied.');



if (empty($action) || $action == 'list') {

    $parent_pid = param('parent_pid', 0);
    $pid        = param('pid', 0);
    $page       = param('page', 0);
    $name       = param('name', '');

    $where = array('pid' => $pid, 'status' => array('>=' => 0));

    if (!empty($name)) {

        $where['name'] = array('LIKE' => $name);

    }

    if ($page > 0) {
        $where = cache_get('last_menu_search');
    } else {
        cache_set('last_menu_search', $where);
        $page = 1;
    }
    $pagenum    = $conf['pagesize'];
    $menulist   = menu_find($where, '', $page, $pagenum);
    $totalnum   = menu_count($where);
    $pagination = pagination(r_url('menu-list', array('page' => 'pagenum')), $totalnum, $page, $pagenum);
    include ADMIN_PATH . "view/menu_list.html";

} else if ($action == 'add') {
    if ($method == 'POST') {

        $dataarr = param_post('');

        $checkarr = array(
            'name'   => array(array('length', '菜单名称在3到10个字符之间', array(3, 10)), array('empty', '菜单名称为空'), array('uniqid', '已存在该菜单名称')),
            'icon'   => array(array('empty', '图标为空')),
            'module' => array(array('empty', '模块名称为空')),
        );

        $r = wi_check_field('menu', $dataarr, $checkarr, 'add');

        if (!$r[0]) {
            message(-1, $r[1], array('key' => $r[2]));
        }
        $r[1]['create_time'] = $time;
        $result = menu_create($r[1]);
        if ($result) {
            message(0, '添加成功');
        } else {
            message(-1, '添加失败');
        }

    } else {
        $menulist = menu_find(array('pid' => 0, 'is_hide' => 0, 'status' => array('>=' => 0)), '', '', menu_count(array('pid' => 0, 'is_hide' => 0, 'status' => array('>=' => 0))));

        $select = menu_getselect($menulist);
        $pid    = param('pid', 0);
        include ADMIN_PATH . "view/menu_add.html";
    }
} else if ($action == 'edit') {
    if ($method == 'POST') {

        $id   = param('id');
        $info = menu_read($id);

        $dataarr = param_post('');
        if (!empty($dataarr)) {

            $checkarr = array(
                'name'   => array(array('length', '菜单名称在3到10个字符之间', array(3, 10)), array('empty', '菜单名称为空'), array('uniqid', '已存在该菜单名称')),
                'icon'   => array(array('empty', '图标为空')),
                'module' => array(array('empty', '模块名称为空')),
            );

            $r = wi_check_field('menu', $dataarr, $checkarr, 'edit','id',$info);

            if (!$r[0]) {
                message(-1, $r[1], array('key' => $r[2]));
            }
            $r[1]['update_time'] = $time;
            $result = menu_update($id, $r[1]);
            if ($result) {
                message(0, '编辑成功');
            } else {
                message(-1, '编辑失败');
            }
        } else {
            message(-1, '未有数据被更改');
        }

    } else {
        $id       = param('id');
        $info     = menu_read($id);
        $menulist = menu_find(array('pid' => 0, 'is_hide' => 0, 'status' => array('>=' => 0)), '', '', menu_count(array('pid' => 0, 'is_hide' => 0, 'status' => array('>=' => 0))));

        $select = menu_getselect($menulist);

        include ADMIN_PATH . "view/menu_edit.html";
    }
} else if ($action == 'cstatus') {
    if ($method == 'POST') {
        $id      = param('id');
        $field   = param('field');
        $value   = param('value');
        $message = param('message');
        $result  = menu_update($id, [$field => $value,'update_time'=>$time]);
        if ($result) {
            message(0, $message . '成功');
        } else {
            message(-1, $message . '失败');
        }

    }
} else if ($action == 'forbidden') {
    $id     = param('id');
    $status = param('val');
    if ($status == 1) {
        $status = 0;
    } else {
        $status = 1;
    }

    $result = menu_update($id, ['status' => $status,'update_time'=>$time]);
    if ($result) {
        message(0, '操作成功', array('val' => $status));

    } else {
        message(-1, '操作失败');
    }

} else if ($action == 'delete') {
    $id     = param('id');
    $result = menu_update($id, ['status' => -1,'update_time'=>$time]);
    if ($result) {
        message(0, '删除成功');

    } else {
        message(-1, '删除失败');
    }

}
