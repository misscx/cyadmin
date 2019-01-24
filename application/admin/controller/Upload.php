<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：文件上传控制器。
*
**/

namespace app\admin\controller;

use think\facade\Request;

class Upload extends Common
{
    public function uploadpic($name='image', $width='100', $height='100', $url='')
    {
        $url = base64_decode($url);
        $file = $this->uploadsave($name);
        if ($file) {
            $url = $file;
        }
        $this->assign('name', $name);
        $this->assign('width', $width);
        $this->assign('height', $height);
        $this->assign('url', $url);
        return $this->fetch();
    }

    public function uploadpics($name='images', $url='')
    {
        $url = base64_decode($url);
        if (Request::isPost()) {
            $images = array_filter(explode('|', input('post.url')));
        } else {
            $images = array_filter(explode('|', $url));
        }
        $file = $this->uploadsave($name);
        if ($file) {
            array_push($images, $file);
        }
        $url = implode('|', $images);

        $this->assign('url', $url);
        $this->assign('images', $images);
        $this->assign('name', $name);
        return $this->fetch();
    }

    private function uploadsave($name)
    {
        if (Request::isPost()) {
            $file = request()->file($name);
            $info = $file->validate(['size'=>4194304,'ext'=>'bmp,jpg,jpeg,png,tif,gif,svg,webp'])
                ->move( 'static/upload');
            if($info){
                return '/static/upload/'.$info->getSaveName();
            }else{
                return false;
            }
        }
    }
}
