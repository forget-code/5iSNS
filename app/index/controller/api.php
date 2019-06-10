<?php

!defined('DEBUG') and exit('Access Denied.');
require EXTEND_PATH . 'pay/Alipay/SDK.php';
require EXTEND_PATH . 'pay/Alipay/Params/Pay/Request.php';
require EXTEND_PATH . 'pay/Alipay/Params/PublicParams.php';
use Yurun\PaySDK\Alipay\SDK;

($uid <= 0) and message(-1, '请先登录');
//还需要验证token之类的
if ($action == 'focus') {
//type关联目标类型0用户1帖子2话题3文档
    //关联数据表usersandother

    $type   = param(3, 0);
    $val    = param('val');
    $insert = array(
        'type' => $type,
        'uid'  => $uid,
        'did'  => $val,
    );
    $delete_message = '';
    $r              = db_find_one('usersandother', $insert);
    if ($r) {
        $myoprate = '-';
    } else {
        $myoprate = '+';
    }

    if ($type == 1) {
        $suc_message = '收藏成功';
        $err_message = '收藏失败';
        $topicinfo   = topic_read($val);
        $name        = $topicinfo['title'];
        if (!$topicinfo) {
            message(-1, '该帖子不存在');
        }
        $icon['qx']    = 'star-o';
        $icon['focus'] = 'star';
        $typename      = '帖子';

        user_extend_update($topicinfo['uid'], array('focus_mytopic_num' . $myoprate => 1));
        user_extend_update($uid, array('focus_topic_num' . $myoprate => 1));

    } elseif ($type == 2) {
        $icon['qx']     = 'plus';
        $icon['focus']  = 'minus';
        $topiccate_info = topiccate_read($val);
        $name           = $topiccate_info['name'];
        if (!$topiccate_info) {
            message(-1, '该话题不存在');
        }
        $typename    = '话题';
        $suc_message = '关注成功';
        $err_message = '关注失败';

        if ($topiccate_info['uid'] > 0) {
            user_extend_update($topiccate_info['uid'], array('focus_mycate_num' . $myoprate => 1));
        }
        topiccate_update($topiccate_info['id'], array('user_num' . $myoprate => 1));
        user_extend_update($uid, array('focus_cate_num' . $myoprate => 1));
    } elseif ($type == 3) {

        $suc_message = '收藏成功';
        $err_message = '收藏失败';
        $topicinfo   = doc_read($val);
        $name        = $topicinfo['title'];
        if (!$topicinfo) {
            message(-1, '该文档不存在');
        }
        $icon['qx']    = 'star-o';
        $icon['focus'] = 'star';
        $typename      = '文档';

        user_extend_update($topicinfo['uid'], array('focus_mydoc_num' . $myoprate => 1));
        user_extend_update($uid, array('focus_doc_num' . $myoprate => 1));
    } else {
        $typename    = '用户';
        $suc_message = '关注成功';
        $err_message = '关注失败';
        $userinfo    = user_read_cache($val);
        $name        = $userinfo['nickname'];
        if (!$userinfo) {
            message(-1, '该用户不存在');
        }
        if ($uid == $userinfo['id']) {
            message(-1, '自己关注自己是不是太自恋了');
        }
        $icon['qx']    = 'plus';
        $icon['focus'] = 'minus';
        user_extend_update($userinfo['id'], array('fensi_num' . $myoprate => 1));
        user_extend_update($uid, array('focus_user_num' . $myoprate => 1));

    }

    if ($r) {
        $result         = db_delete('usersandother', array('id' => $r['id']));
        $delete_message = '取消';
        $extra['icon']  = $icon['qx'];

    } else {
        $insert['name']        = $name;
        $insert['create_time'] = $time;
        $result                = db_create('usersandother', $insert);
        $extra['icon']         = $icon['focus'];

        if ($type == 0) {

$subject = '<a href="' . r_url('user-' . $uid) . '">' . $user['nickname'] . '</a>关注了你';
$mail_subject = '<a href="' . http_url_path() . r_url('user-' . $uid) . '">' . $user['nickname'] . '</a>关注了你';

send_message($val,$subject,$mail_subject,'someone_focusme');
 



        }

    }

    if ($result) {

        message(0, $typename . $delete_message . $suc_message, $extra);
    } else {
        message(-1, $typename . $delete_message . $err_message);
    }

} elseif ($action == 'sixin') {

    $touid = param('uid');
    $type  = param('type');

    $content = param('content');
    $touser = user_qx_cache($touid);
    if ($touser['extend']['notify']['sxtype'] == 0) {
        message(-1, '该用户拒绝接收私信');
    }
    $focususers = db_find_column('usersandother', array('type' => 0, 'uid' => $touid), 'did');
    if ($touser['extend']['notify']['sxtype'] == 2) {

        if (!in_array($uid, $focususers)) {
            message(-1, '该用户只允许接收关注人的私信');
        }
    }
    if ($touser['extend']['notify']['sxtype'] == 3) {

        $friendusers = db_find_column('usersandother', array('type' => 0, 'did' => $touid, 'uid' => $focususers), 'uid');

        if (!in_array($uid, $friendusers)) {
            message(-1, '该用户只允许接收好友的私信');
        }
    }

    $r = db_minid('message', 'create_time', array('uid' => array($uid, $touid), 'touid' => array($uid, $touid)));

    if ($r) {
        $flag = $r;
    } else {
        $flag = $time;
    }
    $insert = array(
        'type'        => $type,
        'uid'         => $uid,
        'touid'       => $touid,
        'create_time' => $time,
        'content'     => $content,
        'id_to_id'    => $flag,
    );
    $result = db_create('message', $insert);

    if ($result) {

        message(0, '私信成功');
    } else {
        message(-1, '私信失败，请稍后再试');
    }
} elseif ($action == 'dashang') {

    $pay_method = param('pay_method');
    $score      = intval(param('score'));
    $content    = param('content');

    $id   = param('id');
    $info = topic_read($id);
    empty($info) and message(-1, '帖子不存在');

    if (empty($pay_method)) {
        message(-1, '请选择支付方式');
    }
    if ($score < 1) {
        message(-1, '怎么的也要打赏点吧');
    }

    if ($pay_method == 'alipay') {
        $out_trade_no = xn_safe_key();
        $insert       = array(
            'rmb'          => $score,
            'type'         => 1,
            'actiontype'   => 2,
            'itemid'       => $id,
            'out_trade_no' => $out_trade_no,
            'score'        => $conf['chongzhi']['bili'] * $score,
            'uid'          => $info['uid'],
            'create_time'  => $time,
            'errorcode'    => $content,

        );
        $result = db_create('chongzhi', $insert);
        if ($result) {

            $params         = new \Yurun\PaySDK\Alipay\Params\PublicParams;
            $params->appID  = $conf['alipay']['appID'];
            $params->md5Key = $conf['alipay']['md5Key'];
            $pay            = new SDK($params);

// 支付接口
            $request                               = new \Yurun\PaySDK\Alipay\Params\Pay\Request;
            $request->notify_url                   = $conf['web_url'] . '/api-pay_notify_url'; // 支付后通知地址（作为支付成功回调，这个可靠）
            $request->return_url                   = $conf['web_url'] . '/api-pay_return_url'; // 支付后跳转返回地址
            $request->businessParams->seller_id    = $conf['alipay']['appID']; // 卖家支付宝用户号
            $request->businessParams->out_trade_no = $out_trade_no; // 商户订单号
            $request->businessParams->total_fee    = $score; // 价格
            $request->businessParams->subject      = '帖子打赏'; // 商品标题

// 跳转到支付宝页面
            $url = $pay->redirectExecute($request, true);
            message(0, '打赏成功', array('url' => $url));
        }
    }

    if ($pay_method == 'caifu') {

        if ($user['extend']['point'] < $conf['chongzhi']['bili'] * $score) {
            message(-1, '余额不足');
        }

        $pointdata['uid']         = $uid;
        $pointdata['to_uid']      = $info['uid'];
        $pointdata['description'] = '打赏';
        $pointdata['itemid']      = $id;

        point_note_op(6, $conf['chongzhi']['bili'] * $score, 'point', '-', $pointdata);
        if (!empty($content)) {
            send_sys_message($info['uid'], '用户' . $user['nickname'] . '在帖子《' . $info['title'] . '》打赏了你，并给你留言：</br>' . $content);
        } else {
            send_sys_message($info['uid'], '用户' . $user['nickname'] . '在帖子《' . $info['title'] . '》打赏了你');
        }
        message(0, '打赏成功');
    }

} elseif ($action == 'pay_return_url') {
    $out_trade_no = param('out_trade_no');
    //支付宝交易号

    $trade_no = param('trade_no');

    //交易状态
    $trade_status        = param('trade_status');
    $map['out_trade_no'] = $out_trade_no;
    $info                = db_find_one('chongzhi', $map);
    if ($info['type'] == 1) {

        $params         = new \Yurun\PaySDK\Alipay\Params\PublicParams;
        $params->appID  = $conf['alipay']['appID'];
        $params->md5Key = $conf['alipay']['md5Key'];
        $pay            = new SDK($params);
        $verify_result  = $pay->verifyCallback($_GET);

        if ($verify_result) {
//验证成功

            if ($info['status'] != 1) {

                $data['status']      = 1;
                $data['trade_no']    = $trade_no;
                $data['update_time'] = $time;
                db_update('chongzhi', $map, $data);

                if ($info['actiontype'] == 2) {
                    $info                     = topic_read($info['itemid']);
                    $pointdata['uid']         = $info['uid'];
                    $pointdata['to_uid']      = $uid;
                    $pointdata['description'] = '打赏';
                    $pointdata['itemid']      = $info['id'];

                    point_note_op(6, $info['score'], 'point', '+', $pointdata);

                    if (!empty($info['errorcode'])) {
                        send_sys_message($info['uid'], '用户' . $user['nickname'] . '在帖子《' . $info['title'] . '》打赏了你，并给你留言：</br>' . $info['errorcode']);
                    } else {
                        send_sys_message($info['uid'], '用户' . $user['nickname'] . '在帖子《' . $info['title'] . '》打赏了你');
                    }

                } else {
                    $pointdata['description'] = '充值';
                    $pointdata['uid']         = $uid;
                    $pointdata['to_uid']      = 0;

                    point_note_op(4, $info['score'], 'point', '+', $pointdata);
                }
            }

            echo "success";
            if ($info['actiontype'] == 1) {
                http_location(r_url('user-' . $uid));
            }
            if ($info['actiontype'] == 2) {
                http_location(r_url('thread-' . $info['itemid']));
            }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        } else {
            //验证失败

            $data['trade_no']    = $trade_no;
            $data['errorcode']   = param('trade_status');
            $data['update_time'] = $time;
            db_update('chongzhi', $map, $data);

            echo "fail";

        }
    }
} elseif ($action == 'pay_notify_url') {

    $out_trade_no = param('out_trade_no');
    //支付宝交易号

    $trade_no = param('trade_no');

    //交易状态
    $trade_status        = param('trade_status');
    $map['out_trade_no'] = $out_trade_no;
    $info                = db_find_one('chongzhi', $map);
    if ($info['type'] == 1) {

        $params         = new \Yurun\PaySDK\Alipay\Params\PublicParams;
        $params->appID  = $conf['alipay']['appID'];
        $params->md5Key = $conf['alipay']['md5Key'];
        $pay            = new SDK($params);
        $verify_result  = $pay->verifyCallback($_GET);

        if ($verify_result) {
//验证成功

            if ($info['status'] != 1) {

                $data['status']      = 1;
                $data['trade_no']    = $trade_no;
                $data['update_time'] = $time;
                db_update('chongzhi', $map, $data);

                if ($info['actiontype'] == 2) {
                    $info                     = topic_read($info['itemid']);
                    $pointdata['uid']         = $info['uid'];
                    $pointdata['to_uid']      = $uid;
                    $pointdata['description'] = '打赏';
                    $pointdata['itemid']      = $info['id'];

                    point_note_op(6, $info['score'], 'point', '+', $pointdata);
                } else {
                    $pointdata['description'] = '充值';
                    $pointdata['uid']         = $uid;
                    $pointdata['to_uid']      = 0;

                    point_note_op(4, $info['score'], 'point', '+', $pointdata);
                }

            }

            echo "success";
            if ($info['actiontype'] == 1) {
                http_location(r_url('user-' . $uid));
            }
            if ($info['actiontype'] == 2) {
                http_location(r_url('thread-' . $info['itemid']));
            }
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        } else {
            //验证失败

            $data['trade_no']    = $trade_no;
            $data['errorcode']   = param('trade_status');
            $data['update_time'] = $time;
            db_update('chongzhi', $map, $data);

            echo "fail";

        }
    }
} elseif ($action == 'tixian') {

   $score = intval(param('score', 0));
   $rmb = floor((100-$conf['tixian']['bili'])*$score/(100*$conf['chongzhi']['bili']));
   if ($rmb < 1) {
        message(-1, '提现金额不足1元');
   }
   if ($score < 1) {
        message(-1, '提现积分不足1元');
   }
   if($score>$user['extend']['point']){
     message(-1, '提现积分超出已有数量');
   }
   $type = param('type', 1);
  
   $account = param('account', '');




   $insert       = array(
        'score'        => $score,
        'rmb'          => $rmb,
        'type'         => $type,
        'account'   => $account,
        'uid'          => $uid,
        'create_time'  => $time,
        'status'  => 0,
    );
    $result = db_create('tixian', $insert);
if ($result) {
    message(0, '提现申请成功');
}else{
    message(-1, '提现申请失败');

}

} elseif ($action == 'chongzhi') {
    $type = param('type', 1);

    $chongzhi = param('chongzhi', 1);
    if (intval($chongzhi) < 1) {
        message(-1, '最少充值1元');
    }
    $chongzhi     = intval($chongzhi);
    $out_trade_no = xn_safe_key();
    $insert       = array(
        'rmb'          => $chongzhi,
        'type'         => $type,
        'actiontype'   => 1,
        'itemid'       => 0,
        'out_trade_no' => $out_trade_no,
        'score'        => $conf['chongzhi']['bili'] * $chongzhi,
        'uid'          => $uid,
        'create_time'  => $time,
    );
    $result = db_create('chongzhi', $insert);

    if ($result) {

        if ($type == 1) {
//表示支付宝
            $params         = new \Yurun\PaySDK\Alipay\Params\PublicParams;
            $params->appID  = $conf['alipay']['appID'];
            $params->md5Key = $conf['alipay']['md5Key'];
            $pay            = new SDK($params);

// 支付接口
            $request                               = new \Yurun\PaySDK\Alipay\Params\Pay\Request;
            $request->notify_url                   = $conf['web_url'] . '/api-pay_notify_url'; // 支付后通知地址（作为支付成功回调，这个可靠）
            $request->return_url                   = $conf['web_url'] . '/api-pay_return_url'; // 支付后跳转返回地址
            $request->businessParams->seller_id    = $conf['alipay']['appID']; // 卖家支付宝用户号
            $request->businessParams->out_trade_no = $out_trade_no; // 商户订单号
            $request->businessParams->total_fee    = $chongzhi; // 价格
            $request->businessParams->subject      = '积分充值'; // 商品标题

// 跳转到支付宝页面
            $url = $pay->redirectExecute($request, true);
        }

        message(0, '充值成功', array('url' => $url));
    } else {
        message(-1, '充值失败，请稍后再试');
    }

} elseif ($action == 'delmess') {

    $r  = db_update('message', array('touid' => $uid, 'type' => 2), array('status' => 2));
    $r1 = db_delete('message', array('touid' => $uid, 'type' => 1));

    $list = db_find_all('message', array('touid' => 0, 'type' => 1));

    foreach ($list as $key => $vo) {
        db_create('usersandother', array('uid' => $uid, 'type' => 4, 'did' => $vo['id'], 'create_time' => $time, 'status' => 1, 'name' => $vo['content']));
    }

    message(0, '消息已全部清空', array('url' => r_url('user-notification')));
} elseif ($action == 'readmess') {
    $id       = param('id');
    $info     = db_find_one('message', array('id' => $id));
    $type     = param('type');
    $mess_uid = param('uid');

    if ($type == 1) {
        //系统消息
        if ($info['touid'] == $uid) {
            db_delete('message', array('id' => $id));
        } else {
            db_create('usersandother', array('uid' => $uid, 'type' => 4, 'did' => $id, 'create_time' => $time, 'status' => 1, 'name' => $info['content']));
        }
    }

    if ($type == 2) {
        //私信更新两人所有对话为已读
        $r = db_update('message', array('uid' => $mess_uid, 'touid' => $uid, 'type' => 2), array('status' => 2));
    }

    message(0, '消息已标记已读');

}
