<?php

namespace app\admin\validate;

use think\Validate;

class LoginValidate extends Validate
{
    //用法一：
    protected $rule = [
        ['username', 'require', '用户名不能为空'],
        ['password', 'require', '密码不能为空'],
    ];

    //用法二：
    // protected $rule = [
    // 	'username' => 'require',
    // 	'password' => 'require',
    // ];
    // protected $message = [
    // 	'username.require' => '用户名不能为空1',
    // 	'password.require' => '密码不能为空2',
    // ];
}
