<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-12
* 功能说明：自定义变量控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;
use \think\Input;
use \think\Request;

class Variable extends Common {

    public function index($act=null) {
		
		if($act == 'del'){
			if(!Request::instance()->isPost()){
				return $this->error('参数错误，请重试！');
			}
			$ids = Input::post();
			if(!empty($ids)){
				$r = Db::name('setting')->where(['type'=>1])->delete($ids['ids']);
				if($r) {
					addlog('删除自定义变量，变量名：'.implode(',',$ids['ids']),$this->user['username']);
					return $this->success('恭喜，菜单删除成功！',url('admin/variable/index'));
				}
			}
			return $this->error('请选择需要删除的选项！');
		}
		
		if($act == 'edit'){
			$k = Input::get('k/s');
			$var = Db::name('setting')->where(['k'=>$k,'type'=>1])->find();
			if(!$var) {
				return $this->error('参数错误，请重试！');
			}
			$this->assign('var',$var);
			return $this->fetch('form');
		}
		
		if($act == 'update'){
			if(!Request::instance()->isPost()){
				return $this->error('参数错误，请重试！');
			}
			$k = Input::post('k/s');
			$var = Input::post('var/s');
			$v = Input::post('v');
			$name = Input::post('name');
			$tips = Input::post('tips');
			$o = Input::post('o',0,'intval');

			if($var == ''){
				return $this->error('变量名不能为空！');
			}
			if($name == ''){
				return $this->error('名称不能为空！');
			}
			if(Db::name('setting')->where(['k'=>$var])->count()>0 && $k <> $var) {
				return $this->error('变量名称已存在，请重试！');
			}

			if($k == ''){//新增
				Db::name('setting')->insert(['k'=>$var,'v'=>$v,'name'=>$name,'tips'=>$tips,'type'=>1,'o'=>$o]);
				addlog('新增自定义变量，变量名:'.$var,$this->user['username']);
				return $this->success('恭喜，新增自定义变量成功！',url('admin/variable/index'));
			}else{//编辑
				Db::name('setting')->where('k', $k)->update(['k'=>$var,'v'=>$v,'name'=>$name,'tips'=>$tips,'type'=>1,'o'=>$o]);
				addlog('编辑菜单，变量名:'.$k,$this->user['username']);
				return $this->success('恭喜，编辑自定义变量成功！',url('admin/variable/index'));
			}
			
			return $this->error('系统错误，请稍后再试！');
		}
		
		if($act == 'add'){
			return $this->fetch('form');
		}
		
		$vars = Db::name('setting')->where(['type'=>1])->select();
		$this->assign('vars',$vars);
		return $this->fetch();
    }
}