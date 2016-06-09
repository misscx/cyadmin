<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-06
* 功能说明：后台公用控制器。
*
**/

namespace app\admin\Controller;
use app\admin\model\User;
use think\Controller;
use think\Config;
use think\Cookie;
use think\Db;



class Common extends Controller {
	
	public $user = false;
	
	public function __construct() {
		
		//登录判断
		$auth = Cookie::get('auth');
		list($identifier, $token) = explode(',', $auth);
		if (ctype_alnum($identifier) && ctype_alnum($token)) {
			$user = User::get(['identifier'=>$identifier,'token'=>$token]);
			if($user){
				if($token == $user->token && $user->identifier == password($user->uid.md5($user->username.$user->salt))){
					$this->user = $user->toArray();
				}
			}
		}
		
		if(!$this->user){
			 $this -> error('请先登录',url('login/index'));
		}
		
		$setting = Db::name('setting')->select();
		$config = array();
		foreach($setting as $k=>$v){
			$config[$v['k']] = $v['v'];
		}
		Config::set($config);
	}
}
