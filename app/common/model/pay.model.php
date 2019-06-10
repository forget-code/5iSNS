<?php

require EXTEND_PATH . 'pay/Alipay/SDK.php';
require EXTEND_PATH . 'pay/Alipay/Params/Pay/Request.php';
require EXTEND_PATH . 'pay/Alipay/Params/PublicParams.php';

function pay($pay_method,$subject,$extra) {
    global $conf;
    $url = '';
	if ($pay_method == 'alipay') {
		$out_trade_no = xn_safe_key();
		$extra['type'] = 1;
        $extra['out_trade_no'] = $out_trade_no;
        $extra['create_time'] = time();

        $result = db_create('chongzhi', $extra);
        if ($result) {

            $params         = new \Yurun\PaySDK\Alipay\Params\PublicParams;
            $params->appID  = $conf['alipay']['appID'];
            $params->md5Key = $conf['alipay']['md5Key'];
            $pay            = new \Yurun\PaySDK\Alipay\SDK($params);

            // 支付接口
            $request                               = new \Yurun\PaySDK\Alipay\Params\Pay\Request;
            $request->notify_url                   = $conf['web_url'] . '/zhifu-pay_notify_url'; // 支付后通知地址（作为支付成功回调，这个可靠）
            $request->return_url                   = $conf['web_url'] . '/zhifu-pay_return_url'; // 支付后跳转返回地址
            $request->businessParams->seller_id    = $conf['alipay']['appID']; // 卖家支付宝用户号
            $request->businessParams->out_trade_no = $out_trade_no; // 商户订单号
            $request->businessParams->total_fee    = $extra['rmb']; // 价格
            $request->businessParams->subject      = $subject; // 商品标题

            $url = $pay->redirectExecute($request, true);
          
         
          
        }else{
        	message(-1, '支付失败');
        }
	}


	return $url;
}
function return_check(){
	    global $conf;
	    $params         = new \Yurun\PaySDK\Alipay\Params\PublicParams;
        $params->appID  = $conf['alipay']['appID'];
        $params->md5Key = $conf['alipay']['md5Key'];
        $pay            = new \Yurun\PaySDK\Alipay\SDK($params);
        $verify_result  = $pay->verifyCallback($_GET);
        return $verify_result;
}


?>