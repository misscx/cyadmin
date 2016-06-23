<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-06
* 功能说明：文章控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;
use \think\Input;
use \think\Request;

class Article extends Common {

    public function index($act=null,$cid=null) {
		if($act=='del'){
			
			if (!Request::instance()->isPost()){
				return $this->error('参数错误，请重试！');
			}
			$aids = Input::post();

			if(!empty($aids)){
				$r = Db::name('article')->delete($aids['aids']);
				Db::name('content')->delete($aids['aids']);
				addlog('删除文章，AID：'.implode(',',$aids['aids']),$this->user['username']);
				return $this->success('恭喜，删除成功！',url('admin/article/index'));
			}

			return $this->error('请选择需要删除的选项！');
		}
		
		$cid = intval($cid);
		if($cid) {
			$where = "a.cid = '{$cid}'";
		}else{
			$where = '1=1';
		}
		$list = Db::name('article')->alias('a')->join('__CATEGORY__ c','a.cid=c.id')->field('a.*,c.name')->where($where)->order('a.aid desc')->paginate(25);
		$this->assign('list',$list);
		return $this->fetch();
    }
	
	public function add(){
		$category = Db::name('category')->field('id,pid,name')->order('o asc')->select();
		$category = $this->getMenu($category);
		$this->assign('category',$category);
		
		return $this->fetch();
	}
	
	public function edit($aid=null){
		$aid = intval($aid);
		$article = Db::name('article')->where(['aid'=>$aid])->find();
		if(!$article){
			return $this->error('参数错误，请重试！');
		}
		$content = Db::name('content')->field('content')->where(['aid'=>$aid])->find();
		if(!$article){
			return $this->error('参数错误，请重试！');
		}
		$article = array_merge($article,$content);
		$category = Db::name('category')->field('id,pid,name')->order('o asc')->select();
		$category = $this->getMenu($category);
		$this->assign('category',$category);
		$this->assign('article',$article);
		return $this->fetch();
	}
	
	public function save($aid=null){
		if (!Request::instance()->isPost()){
			return $this->error('参数错误，请重试！');
		}
		$aid = intval($aid);
		$cid = Input::post('cid',0,'intval');
		if (!$cid){
			return $this->error('参数错误，请重试！');
		}
		$title = Input::post('title');
		$keywords = Input::post('keywords');
		$description = Input::post('description');
		$image = Input::post('image');
		$t = time();
		$stick = Input::post('stick',0,'intval');
		$content = Input::post('content');
		if(!$aid){
			$aid = Db::name('article')->insert(['cid'=>$cid,'title'=>$title,'keywords'=>$keywords,'description'=>$description,'image'=>$image,'t'=>$t,'stick'=>$stick],false,true);
			if(!$aid){
				return $this->error('系统错误，请稍后重试！');
			}
			Db::name('content')->insert(['aid'=>$aid,'content'=>$content]);
			addlog('新增文章，AID：'.$aid,$this->user['username']);
			return $this->success('恭喜，新增文章成功！',url('admin/article/index'));
		}else{
			Db::name('article')->where(['aid'=>$aid])->update(['cid'=>$cid,'title'=>$title,'keywords'=>$keywords,'description'=>$description,'image'=>$image,'t'=>$t,'stick'=>$stick]);
			Db::name('content')->where(['aid'=>$aid])->update(['aid'=>$aid,'content'=>$content]);
			addlog('编辑文章，AID：'.$aid,$this->user['username']);
			return $this->success('恭喜，文章编辑成功！',url('admin/article/index'));
		}
		
	}
}