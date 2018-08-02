<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：自定义变量控制器。
*
**/

namespace app\admin\controller;

use think\Db;
use think\facade\Request;

class Variable extends Common
{
    public function index($act=null)
    {
        if ($act == 'del') {
            if (!Request::isPost()) {
                return $this->error('参数错误，请重试！');
            }
            $ids = input('post.ids');
            if (!empty($ids)) {
                foreach ($ids as $k=>$v) {
                    unset($this->cyConfig['custom'][$v]);
                }
                sort($this->cyConfig['custom']);
                $config_file='config/cy.php';
                if (!is_writable($config_file)) {
                    return $this->error('请确保config/cy.php文件可读写');
                }

                $result = file_put_contents($config_file, "<?php\r\nreturn " . var_export($this->cyConfig, true) . ";");
                if ($result) {
                    addlog('删除自定义变量。', $this->user['username']);
                    return $this->success('操作成功', url('index'));
                } else {
                    return $this->error('参数错误，请重试！');
                }
            }
            return $this->error('请选择需要删除的选项！');
        }

        if ($act == 'edit') {
            $k = input('param.k/d');
            if (!isset($this->cyConfig['custom'][$k])) {
                return $this->error('参数错误，请重试！');
            }
            $this->assign('k', $k);
            return $this->fetch('form');
        }

        if ($act == 'update') {
            if (!Request::isPost()) {
                return $this->error('参数错误，请重试！');
            }
            $data = input('post.');

            if ($data['name'] == '') {
                return $this->error('名称不能为空！');
            }
            if ($data['var'] == '') {
                return $this->error('变量名不能为空！');
            }

            $this->cyConfig['custom'] = array_merge($this->cyConfig['custom'], [$data]);

            $config_file='config/cy.php';
            if (!is_writable($config_file)) {
                return $this->error('请确保config/cy.php文件可读写');
            }
            $result = file_put_contents($config_file, "<?php\r\nreturn " . var_export($this->cyConfig, true) . ";");
            if ($result) {
                addlog('新增自定义变量。', $this->user['username']);
                return $this->success('操作成功', url('index'));
            } else {
                return $this->error('参数错误，请重试！');
            }
        }

        if ($act == 'add') {
            $this->assign('k', false);
            return $this->fetch('form');
        }
        return $this->fetch();
    }
}
