<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-06
* 功能说明：后台用户登录控制器。
*
**/
namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Controller;
use \think\Cookie;
use \think\Db;

class Login extends Common {
	
    public function index(){
		
		$auth = Cookie::get('auth');
		if($auth) {
			list($identifier, $token) = explode(',', $auth);
			if (ctype_alnum($identifier) && ctype_alnum($token)) {
				$user = Db::name('user')->alias('u')->join('__USER_GROUP__ g','u.ugid=g.id')->where("u.identifier='{$identifier}' and u.token='{$token}' and u.status=1 and g.status=1")->field('u.*,g.title,g.auth')->find();
				if($user){
					if($token == $user['token'] && $user['identifier'] == password($user['uid'].md5($user['username'].$user['salt']))){
						return $this -> success('您已登录，正在跳转！',url('admin/index/index'));
					}
				}
			}
		}
		return $this->fetch();
    }
	
	public function login(){

		$verify = input('post.verify');
		if (!captcha_check($verify, 'login')) {
            $this->error('验证码错误');
        }
		$username = input('post.username');
		$password = input('post.password');
		$remember = input('post.remember');
		
		if ($username=='') {
			return $this -> error('用户名不能为空！',url('login/index'));
		} elseif ($password=='') {
			return $this -> error('密码必须！',url('login/index'));
		}
		$user = Db::name('user')->field('uid,username')->where(['status'=>1,'username'=>$username,'password'=>password($password)]) -> find();
		if($user){
			$token = password(uniqid(rand(), TRUE));
			$salt = random(10);
			$identifier = password($user['uid'].md5($user['username'].$salt));
			$auth = $identifier.','.$token;
			Db::name('user')->where(array('uid'=>$user['uid']))->update(array('identifier'=>$identifier,'token'=>$token,'salt'=>$salt));
			if($remember){
				Cookie::set('auth',$auth,3600*24*365);
			}else{
				Cookie::set('auth',$auth);
			}
			addlog('登录成功。',$user['username']);
			return $this -> success('恭喜，登录成功！',url('admin/index/index'));

		}else{
			addlog('用户或密码错误。',$username);
			return $this -> error('用户名或密码错误，请稍后再试！',url('login/index'));
		}
    }
}