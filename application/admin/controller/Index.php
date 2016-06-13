<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-06
* 功能说明：后台首页控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;

class Index extends Common {

    public function index() {
		
		return $this->fetch();
    }
}