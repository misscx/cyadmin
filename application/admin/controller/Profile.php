<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-18
* 功能说明：个人资料控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Input;
use \think\Db;

class Profile extends Common {

    public function index($act=null) {
		
		
		if($act=='update'){
			
			$data['avatar'] = Input::post('avatar');
			$data['sex'] = Input::post('sex/d');
			$data['password'] = Input::post('password');
			$data['birthday'] = strtotime(Input::post('birthday'));
			$data['tel'] = Input::post('tel');
			$data['qq'] = Input::post('qq');
			$data['email'] = Input::post('email');
			if($data['password']==''){
				unset($data['password']);
			}else{
				$data['password'] = password($data['password']);
			}
			$r = Db::name('user')->where(['uid'=>$this->user['uid']])->update($data);
			if($r){
				addlog('修改个人资料，ID：'.$this->user['uid'],$this->user['username']);
				return $this->success('恭喜，个人资料修改成功！',url('admin/profile/index'));
			}else{
				return $this->error('参数错误，请重试！');
			}
			
		}
		
		return $this->fetch();
    }
}