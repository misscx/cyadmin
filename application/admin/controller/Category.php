<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：分类控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;
use \think\Request;

class Category extends Common {

    public function index($act=null) {
    
        if($act=='del'){
            if (!Request::instance()->isPost()){
                return $this->error('参数错误，请重试！');
            }
            $ids = input('post.');

            if(!empty($ids)){
                $r = Db::name('category')->delete($ids['ids']);
                if($r) {
                    addlog('删除分类，ID：'.implode(',',$ids['ids']),$this->user['username']);
                    return $this->success('恭喜，分类删除成功！',url('admin/category/index'));
                }
            }
            return $this->error('请选择需要删除的分类！');
        }
    
        $category = Db::name('category')->field('id,pid,name,o,type')->order('o asc')->select();
        $category = $this->getMenu($category);
        $this->assign('category',$category);
        return $this->fetch();
    }
  
    public function add($pid=null){

        $pid = intval($pid);

        $category = Db::name('category')->field('id,pid,name')->order('o asc')->select();
        $category = $this->getMenu($category);
        $this->assign('category',$category);
        $this->assign('pid',$pid);

        return $this->fetch();
    }

    public function edit($id){
        $id = intval($id);
        $current_category = Db::name('category')->where(['id'=>$id])->find();
        if(!$current_category){
            return $this->error('参数错误，请重试！');
        }
        $category = Db::name('category')->field('id,pid,name')->order('o asc')->select();

        $category = $this->getMenu($category);
        $this->assign('current_category',$current_category);
        $this->assign('category',$category);
        $this->assign('id',$id);
        return $this->fetch();
    }
  
    public function save($id=null){
        if (!Request::instance()->isPost()){
            return $this->error('参数错误，请重试！');
        }
        $data = input('post.');
        if($data['name']==''){
            return $this->error('分类名称不能为空！');
        }
        $id = intval($id);
        $data['o'] = intval($data['o']);
        if($id){
            $r = Db::name('category')->where(['id'=>$id])->update($data);
            addlog('编辑分类，ID：'.$id,$this->user['username']);
        }else{
            $r = Db::name('category')->insert($data);
            addlog('新增分类，名称：'.$data['name'],$this->user['username']);
        }
        if($r){
            return $this -> success('恭喜，操作成功！',url('admin/category/index'));
        }else{
            return $this->error('系统错误，请重试！');
        }
    }
}