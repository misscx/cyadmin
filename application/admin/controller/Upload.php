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
use \think\Request;

class Upload extends Common {

    public function uploadpic($name='image',$width='100',$height='100',$url='') {
		
		$file = $this->uploadsave($name);
		if($file){
			$url = $file;
		}
		$this->assign('name',$name);
		$this->assign('width',$width);
		$this->assign('height',$height);
		$this->assign('url',$url);
		return $this->fetch();
    }

	public function uploadpics($name='images',$url=''){
		
		$images = array_filter(explode('|',$url));
	
		$file = $this->uploadsave($name);
		if($file){
			array_push($images, $file);
		}
		$url = implode('|',$images);
		
		
		$this->assign('url',$url);
		$this->assign('images',$images);
		$this->assign('name',$name);
		return $this->fetch();
	}

	private function uploadsave($name){
		if(Request::instance()->isPost()){
			$accept=array(
				'image/jpeg',
				'image/jpg',
				'image/jpeg',
				'image/png',
				'image/pjpeg',
				'image/gif',
				'image/bmp',
				'image/x-png'
			);

			$file = Input::file($name);

			if(in_array($file->getMime(),$accept)){
				$info = $file->move('static/upload');
				if($info){
					return str_replace('\\','/','/'.$info->getPath().'/'.$info->getFilename());
				}else{
					//return $file->getError();
					return false;
				}
			}else{
				return false;
			}
		}
	}
}