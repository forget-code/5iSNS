<?php
/**
 * @authors 5iSNS实验室 (admin@5isns.com)
 * @date    2019-03-30 18:27:46
 * @version 1.0.0
 */
!defined('DEBUG') and exit('Access Denied.');

include PUBLIC_MODEL_PATH.'smtp.model.php';
$smtplist = smtp_init(DATA_PATH.'config/smtp.conf.php');

 $menu['setting'] = array(
        'url'=>r_url('config-setting'), 
        'text'=>'配置', 
        'icon'=>'fa-cog', 
        'tab'=> array (
            'base'=>array('url'=>r_url('config-setting'), 'text'=>'基础配置'),
            'smtp'=>array('url'=>r_url('config-smtp'), 'text'=>'邮箱配置'),
            'chongzhi'=>array('url'=>r_url('config-chongzhi'), 'text'=>'支付配置'),
           )
       );
if (empty($action) || $action == 'setting') {
    if($method == 'GET') {
if(empty($conf['online_trans_num'])){
    $conf['online_trans_num']=0;
}
        $input = array();
        $input['sitename'] = form_text('sitename', $conf['sitename']);
        $input['sitebrief'] = form_textarea('sitebrief', $conf['sitebrief'], '100%', 100);
        $input['beinum'] = form_text('beinum', $conf['beinum']);
        $input['web_url'] = form_text('web_url', $conf['web_url']);
        $input['appid'] = form_text('appid', $conf['appid']);
        

        $input['shuiyin'] = form_text('shuiyin', $conf['shuiyin']);
        $input['sy_type'] = form_radio('sy_type', array('0'=>'关闭','1'=>'文字','2'=>'图片'),$conf['sy_type']);
        $input['user_create_on'] = form_radio_yes_no('user_create_on', $conf['user_create_on']);
        $input['user_create_email_on'] = form_radio_yes_no('user_create_email_on', $conf['user_create_email_on']);
        $input['user_resetpw_on'] = form_radio_yes_no('user_resetpw_on', $conf['user_resetpw_on']);
        $input['online_trans'] = form_radio_yes_no('online_trans', $conf['online_trans']);
        $input['cdn_use'] = form_radio_yes_no('cdn_use', $conf['cdn_use']);
     
        
        
        include ADMIN_PATH.'view/config_setting.html';
        
    } else {
        
        $sitebrief = param('sitebrief', '', FALSE);
        $sitename = param('sitename', '', FALSE);
        $beinum = param('beinum', '', FALSE);
        $web_url = param('web_url', '', FALSE);
        $appid = param('appid', '', FALSE);
       

        $shuiyin = param('shuiyin', '', FALSE);
        $sy_type = param('sy_type', 0);
        $user_create_on = param('user_create_on', 0);
        $user_create_email_on = param('user_create_email_on', 0);
        $user_resetpw_on = param('user_resetpw_on', 0);
        $online_trans = param('online_trans', 0);
        $cdn_use = param('cdn_use', 0);


        $replace = array();
        $replace['sitename'] = $sitename;
        $replace['beinum'] = $beinum;
        $replace['web_url'] = $web_url;
        $replace['appid'] = $appid;
       
        $replace['shuiyin'] = $shuiyin;
        $replace['sy_type'] = $sy_type;

        $replace['sitebrief'] = $sitebrief;
        $replace['user_create_on'] = $user_create_on;
        $replace['user_create_email_on'] = $user_create_email_on;
        $replace['user_resetpw_on'] = $user_resetpw_on;
        $replace['online_trans'] = $online_trans;
        $replace['cdn_use'] = $cdn_use;
        
        
        file_replace_var(DATA_PATH.'config/conf.default.php', $replace);
       
        message(0, '修改成功');
    }
}if ($action == 'chongzhi') {
    if($method == 'GET') {

        $input = array();
        $input['alipay']['appID'] = form_text('appID', $conf['alipay']['appID']);
        $input['alipay']['md5Key'] = form_text('md5Key', $conf['alipay']['md5Key']);
        $input['chongzhi']['bili'] = form_text('czbili', $conf['chongzhi']['bili']);
        $input['tixian']['bili'] = form_text('txbili', $conf['tixian']['bili']);
        
        include ADMIN_PATH.'view/config_chongzhi.html';
        
    } else {
        
        $czbili = param('czbili', '', FALSE);
        $txbili = param('txbili', '', FALSE);
        $md5Key = param('md5Key', '', FALSE);
        $appID = param('appID', '', FALSE);
    if(intval($czbili)<1){
         message(-1, '请填写大于1的整数');
    }
    if(intval($txbili)<1){
         message(-1, '请填写大于1的整数');
    }
        $replace = array();
        $replace['chongzhi']['bili'] = intval($czbili);
        $replace['tixian']['bili'] = intval($txbili);
        $replace['alipay']['md5Key'] = $md5Key;
        $replace['alipay']['appID'] = $appID;
     
        file_replace_var(DATA_PATH.'config/conf.default.php', $replace);
       
        message(0, '修改成功');
    }
} elseif($action == 'smtp') {

   
    
    if($method == 'GET') {
        
        $smtplist = smtp_find();
        $maxid = smtp_maxid();
        
        
        include ADMIN_PATH."view/setting_smtp.html";
    
    } else {
        
        
        $email = param('email', array(''));
        $host = param('host', array(''));
        $port = param('port', array(0));
        $user = param('user', array(''));
        $pass = param('pass', array(''));
        $is_ssl = param('is_ssl', array(''));
        $smtplist = array();
        foreach ($email as $k=>$v) {
            $yes = '';
            $no = '';
            if($is_ssl[$k]==1){
              $yes = 'checked';
            }else{
              $no = 'checked';
            }

            $smtplist[$k] = array(
                'email'=>$email[$k],
                'host'=>$host[$k],
                'port'=>$port[$k],
                'user'=>$user[$k],
                'pass'=>$pass[$k],
                'is_ssl'=>$is_ssl[$k],
                'yes'=>$yes,
                'no'=>$no
            );
        }
        $r = file_put_contents_try(DATA_PATH.'config/smtp.conf.php', "<?php\r\nreturn ".var_export($smtplist,true).";\r\n?>");
        !$r AND message(-1, '写入文件失败');

        
        message(0, '保存成功');
    }
}