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
		
		return $this->fetch('form');
	}
	
	public function edit($id){
		$id = intval($id);
		$banner = Db::name('banner')->where(['id'=>$id])->find();
		if(!$banner){
			return $this->error('参数错误，请重试！');
		}

		$this->assign('banner',$banner);
		return $this->fetch('form');
	}
	
	public function save(){
		if (!Request::instance()->isPost()){
			return $this->error('参数错误，请重试！');
		}
		
		$data = Input::post();
		if($data['title']==''){
			return $this->error('标题不能为空！');
		}
		
		$data['id'] = intval($data['id']);
		$data['o'] = intval($data['o']);
		if(isset($data['status'])){
			$data['status'] = intval($data['status']);
		}else{
			$data['status'] = 0;
		}
		
		if($data['id']){
			$r = Db::name('banner')->where(['id'=>$data['id']])->update($data);
			addlog('编辑横幅，ID：'.$data['id'],$this->user['username']);
		}else{
			unset($data['id']);
			$r = Db::name('banner')->insert($data);
			addlog('新增横幅，标题：'.$data['title'],$this->user['username']);
		}
		if($r){
			return $this -> success('恭喜，操作成功！',url('admin/banner/index'));
		}else{
			return $this->error('系统错误，请重试！');
		}
	}
}