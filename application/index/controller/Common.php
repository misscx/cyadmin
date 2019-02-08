<?php
namespace app\index\controller;

use think\Controller;
use think\facade\Config;

class Common extends Controller
{
    public $cyConfig;
    
    public function initialize()
    {
        $this->cyConfig = Config::get('cy.');
        $this->assign('cyConfig', $this->cyConfig);
    }
}
