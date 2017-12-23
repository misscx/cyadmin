<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：后台首页控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;

class Index extends Common
{
    public function index()
    {
        $mysql = Db::query("select VERSION() as mysql");
        $t = time()-3600*24*60;
        Db::name('log')->where("t < $t")->delete();//删除60天前的日志

        $list = Db::name('log')->order('id desc')->paginate(25);
        $this->assign('list', $list);

        $this->assign('mysql', $mysql[0]['mysql']);
        return $this->fetch();
    }
}
