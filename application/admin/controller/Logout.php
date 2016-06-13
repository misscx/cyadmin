<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-06
* 功能说明：用户退出控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Controller;
use \think\Cookie;


class Logout extends Common {
	
    public function index(){
		Cookie::delete('auth');
		return $this->success('恭喜，退出成功！',url('admin/login/index'));
    }
}