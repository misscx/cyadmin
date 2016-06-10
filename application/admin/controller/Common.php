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

use \think\Controller;
use \think\Config;
use \think\Cookie;
use \think\Db;

class Common extends Controller{
	
	protected $user = false;
	protected $url;
	
	public function _initialize() {

		$this->auth();//权限验证

		//网站设置
		$setting = Db::name('setting')->select();
		$config = array();
		foreach($setting as $k=>$v){
			$config[$v['k']] = $v['v'];
		}
		Config::set($config);

		//菜单
		$current_menu = [];
		$menu = Db::name('menu')->field('id,pid,title,url,icon')->where("status=1 and id in({$this->user['auth']})")->order('o ASC')->select();
		foreach($menu as $k=>$v){
			if($this->url == $v['url']) {
				$current_menu = $v;//当前菜单
				break;
			}
		}
		
		$menu = $this->getMenu($menu);
		
		if($current_menu['pid']<>0){
			$current_menu['parent'] = Db::name('menu')->field('id,pid,title,url,icon')->where(['id'=>$current_menu['pid']])->find();
		}
		
		
		$this->assign('user',$this->user);
		$this->assign('menu',$menu);
		$this->assign('current_menu',$current_menu);
	}
	
	protected function auth(){
		
		//无需登录页面
		$no_need_to_login = [
			'login/index','login/login','login/verify',//登录
			'logout/index',//登出
		];
		
		//登录后无需验证的页面
		$no_need_to_check = [
			'index/index',//首页
		];
		
		$status = false;
		$request = \think\Request::instance();
		$this->url = $request->controller().'/'.$request->action();
		
		//放过无需登录页面
		if(in_array($this->url,$no_need_to_login)){
			return true;
		}

		//登录判断
		$auth = Cookie::get('auth');
		if(!$auth){
			return $this -> error('请先登录',url('admin/login/index'));
		}

		list($identifier, $token) = explode(',', $auth);
		if (ctype_alnum($identifier) && ctype_alnum($token)) {
			$this->user = Db::name('user')->alias('u')->join('__USER_GROUP__ g','u.ugid=g.id')->where("u.identifier='{$identifier}' and u.token='{$token}' and u.status=1 and g.status=1")->field('u.*,g.title,g.auth')->find();
			if($this->user){
				if($token == $this->user['token'] && $this->user['identifier'] == password($this->user['uid'].md5($this->user['username'].$this->user['salt']))){
					$status = true;
				}
			}
		}
		if(!$status){
			return $this -> error('请先登录',url('admin/login/index'));
		}
		if(in_array($this->url,$no_need_to_check)){
			return true;
		}
		
		//验证页面权限
		$current_url_id = Db::name('menu')->field('id')->where(['url'=>$this->url])->find();
		if(in_array($current_url_id['id'],$auth)){
			return true;
		}else{
			return $this -> error('您无权访问此页！');
		}
	}
	
	protected function getMenu($items,$id='id',$pid='pid',$son = 'children'){
		$tree = array();
		$tmpMap = array();
		
		foreach ($items as $item) {
			$tmpMap[$item[$id]] = $item;
		}
		
		foreach ($items as $item) {
			if (isset($tmpMap[$item[$pid]])) {
				$tmpMap[$item[$pid]][$son][] = &$tmpMap[$item[$id]];
			} else {
				$tree[] = &$tmpMap[$item[$id]];
			}
		}
		return $tree;
	}
}
