<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2017-12-22
* 功能说明：后台用户登录控制器。
*
**/
namespace app\admin\Controller;

use app\admin\controller\Common;
use app\admin\model\User;
use think\facade\Cookie;
use app\admin\validate\LoginValidate;

class Login extends Common
{
    public function index()
    {
        $auth = Cookie::get('auth');
        if ($auth) {
            list($identifier, $token) = explode(',', $auth);
            if (ctype_alnum($identifier) && ctype_alnum($token)) {
                $user = User::get(['identifier'=>$identifier,'token'=>$token,'status'=>1]);
                if ($user) {
                    if ($user->group->status == 0) {
                        return $this -> error('所属用户组已被禁用！', url('admin/login/index'));
                    }
                    if ($token == $user->token && $user->identifier == password($user->uid . md5($user->username . $user->salt))) {
                        return $this -> success('您已登录，正在跳转！', url('admin/index/index'));
                    }
                }
            }
        }
        return $this->fetch();
    }

    public function login()
    {
        $username = input('post.username');
        $password = input('post.password');
        $remember = input('post.remember');

        $result = $this->validate(array('username'=>$username,'password'=>$password), 'LoginValidate');

        if ($result !== true) {
            return $this -> error($result, url('login/index'));
        }

        $verify = input('post.verify');
        if (!captcha_check($verify, 'login')) {
            $this->error('验证码错误');
        }

        $user = User::get(['status'=>1,'username'=>$username,'password'=>password($password)]);
        if ($user) {
            if ($user->group->status == 0) {
                return $this -> error('所属用户组已被禁用！', url('admin/login/index'));
            }

            $token = password(uniqid(rand(), true));
            $salt = random(10);
            $identifier = password($user->uid . md5($user->username . $salt));
            $auth = $identifier.','.$token;

            $user->identifier = $identifier;
            $user->token = $token;
            $user->salt = $salt;
            $user->save();

            if ($remember) {
                Cookie::set('auth', $auth, 3600*24*365);
            } else {
                Cookie::set('auth', $auth);
            }
            addlog('登录成功。', $user->username);
            return $this -> success('恭喜，登录成功！', url('admin/index/index'));
        } else {
            addlog('用户或密码错误。', $username);
            return $this -> error('用户名或密码错误，请稍后再试！', url('login/index'));
        }
    }
}
