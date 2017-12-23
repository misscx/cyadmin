<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-09
* 版    本：1.0.0
* 功能说明：后台公共文件。
*
**/

/**
*
* 函数：日志记录
* @param  string $log   日志内容。
* @param  string $name （可选）用户名。
*
**/
function addlog($log, $username=false)
{
    if ($username) {
        \think\Db::name('log')->insert(['username'=>$username,'log'=>$log,'ip'=>$_SERVER["REMOTE_ADDR"],'t'=>time()]);
    }
}
