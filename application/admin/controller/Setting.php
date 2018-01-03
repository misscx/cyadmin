<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：网站设置控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use think\Db;
use think\facade\Config;
use think\facade\Request;

class Setting extends Common
{
    public function index($act=null)
    {
        if ($act == 'update') {
            if (!Request::instance()->isPost()) {
                return $this->error('参数错误，请重试！');
            }
            $data = input('post.');

            foreach ($data as $k=>$v) {
                Db::name('setting')->where(['k'=>$k])->update(['v'=>$v]);//循环插入，效率效差
            }
            addlog('修改网站配置。', $this->user['username']);
            $this->success('恭喜，网站配置成功！', url('index'));
        }

        $setting = Db::name('setting')->field('k,v,name,tips')->order('o ASC')->select();
        $this->assign('setting', $setting);
        return $this->fetch('form');
    }
}
