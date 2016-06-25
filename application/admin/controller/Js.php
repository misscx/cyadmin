<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-06
* 功能说明：JavaScript控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;

class Js extends Common {

    public function js() {
		header('Content-Type: application/x-javascript; charset=utf-8');
		$json = array();
		$list = Db::name('menu')->field('title,url')->where(['status'=>1])->select();
		foreach($list as $k=>$v){
			$json[] = $v['title'];
			$json[] = $v['url'];
		}
		$this->assign('json', json_encode($json));
		return $this->fetch();
    }
}