<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：网站设置控制器。
*
**/

namespace app\admin\controller;

use think\Db;
use think\facade\Config;
use think\facade\Request;

class Setting extends Common
{
    public function index($act=null)
    {
        if ($act == 'update') {
            if (!Request::isPost()) {
                return $this->error('参数错误，请重试！');
            }
            $data = input('post.');
            if (!isset($data['custom'])) {
                $data['custom'] = [];
            }
            $config_file='config/cy.php';
            if (!is_writable($config_file)) {
                return $this->error('请确保config/cy.php文件可读写');
            }

            $result = file_put_contents($config_file, "<?php\r\nreturn " . var_export($data, true) . ";");
            if ($result) {
                addlog('修改网站配置。', $this->user['username']);
                return $this->success('恭喜，网站配置成功！', url('index'));
            } else {
                return $this->error('参数错误，请重试！');
            }
        }
        return $this->fetch('form');
    }
}
