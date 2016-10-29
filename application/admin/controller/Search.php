<?php
/**
*
* 版权所有：恰维网络<www.qiawei.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：后台功能搜索控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;

class Search extends Common {

    public function index() {

        $keyword = Input('post.keyword','','addslashes');
        $list = Db::name('menu')->where("status=1 and (title like '%{$keyword}%' or url like '%{$keyword}%' or tips like '%{$keyword}%')")->select();
        $this->assign('list', $list);
        $this->assign('keyword', $keyword);
        return $this->fetch();
    }
}