<?php
namespace app\admin\controller;
use app\admin\model\User;


class Index extends Common {
	
    public function index() {
		echo url('logoin/login');
		return 'dddd';
    }
}