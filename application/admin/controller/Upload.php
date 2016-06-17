<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-17
* 功能说明：文件上传控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Input;

class Upload extends Common {

    public function uploadpic($name='image',$width='100',$height='100',$url='') {
		
		$this->assign('name',$name);
		$this->assign('width',$width);
		$this->assign('height',$height);
		$this->assign('url',$url);
		return $this->fetch();
    }

	public function upload($name='file'){

		$file = Input::file($name);

		$info = $file->move('static/upload');
		if($info){
			return $file = str_replace('\\','/','/'.$info->getPath().'/'.$info->getFilename());
		}else{
			return $file->getError();
		}
	}
}