<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-11
* 功能说明：后台菜单控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;
use \think\Request;

class Menu extends Common {

    public function index($act=null) {
		
		if($act=='del'){
			
			if (!Request::instance()->isPost()){
				return $this->error('参数错误，请重试！');
			}
			$ids = input('post.');

			if(!empty($ids)){
				$r = Db::name('menu')->delete($ids['ids']);
				if($r) {
					addlog('删除菜单，ID：'.implode(',',$ids['ids']),$this->user['username']);
					return $this->success('恭喜，菜单删除成功！',url('admin/menu/index'));
				}
			}

			return $this->error('请选择需要删除的选项！');
		}
		
		if($act=='update'){
			
			if(!Request::instance()->isPost()){
				return $this->error('参数错误，请重试！');
			}
			$id = input('post.id',0,'intval');
			$pid = input('post.pid',0,'intval');
			$url = input('post.url');
			$title = input('post.title');
			$icon = input('post.icon');
			$tips = input('post.tips');
			$status = input('post.status',0,'intval');
			$o = input('post.o',0,'intval');
			

			if($id==0){//新增
				$id = Db::name('menu')->insert(['pid'=>$pid,'url'=>$url,'title'=>$title,'icon'=>$icon,'tips'=>$tips,'status'=>$status,'o'=>$o],false,true);
				if($id){
					addlog('新增菜单，ID:'.$id,$this->user['username']);
					return $this->success('恭喜，新增菜单成功！',url('admin/menu/index'));
				}
			}else{//编辑
				Db::name('menu')->where('id', $id)->update(['pid'=>$pid,'url'=>$url,'title'=>$title,'icon'=>$icon,'tips'=>$tips,'status'=>$status,'o'=>$o]);
				addlog('编辑菜单，ID:'.$id,$this->user['username']);
				return $this->success('恭喜，编辑菜单成功！',url('admin/menu/index'));
			}
			
			return $this->error('系统错误，请稍后再试！');
		}
		
		if($act=='edit'){
			
			$id = input('get.id/d');
			$this->assign('id',$id);
			
			$current = Db::name('menu')->where(['id'=>$id])->find();
			if(!$current){
				return $this->error('参数错误，请重试！');
			}
			$this->assign('current',$current);
			
			$list = Db::name('menu')->field('id,pid,title')->where(['status'=>1])->order('o ASC')->select();
			$list = $this->getMenu($list);
			$this->assign('list',$list);
			
			return $this->fetch('form');
		}
		
		if($act=='add'){
			
			$list = Db::name('menu')->field('id,pid,title')->where(['status'=>1])->order('o ASC')->select();
			$list = $this->getMenu($list);
			$this->assign('list',$list);
			
			return $this->fetch('form');
		}
		
		$list = Db::name('menu')->field('id,pid,url,title,icon,status,o')->order('o ASC')->paginate(25);
		$this->assign('list', $list);
		return $this->fetch();
    }
}