<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：后台公用控制器。
*
**/

namespace app\admin\Controller;

use \think\Controller;
use app\admin\model\User;
use app\admin\model\Menu;
use app\admin\model\Setting;
use \think\Config;
use \think\Cookie;
use \think\Db;

class Common extends Controller{

    protected $user = false;
    protected $url;

    public function _initialize() {

        $this->auth();//权限验证

        //网站设置
        $setting = Setting::all();
        $config = array();
        foreach($setting as $k=>$v){
            $config[$v->k] = $v->v;
        }
        Config::set($config);

        if($this->user->group->auth){
            //菜单
            $menu = Menu::field('id,pid,title,url,icon,tips')->where("status=1 and id in({$this->user->group->auth})")->order('o', 'asc')->select()->toArray();
            $menu = $this->getMenu($menu);
            $this->assign('menu',$menu);
            //当前菜单
            $current_menu = Menu::name('menu')->field('id,pid,title,url,icon,tips,status')->where(['url'=>$this->url])->find();
            if($current_menu->pid){
                $prefix = Config::get('database.prefix');
                $current_menu['parent'] = Db::query("SELECT c.pid,c.title,c.url,c.icon,p.pid as ppid FROM `{$prefix}menu` as c LEFT JOIN `{$prefix}menu` as p ON p.id=c.pid WHERE ( c.id='{$current_menu['pid']}' ) LIMIT 1");
                $current_menu['parent'] = $current_menu['parent'][0];
                
                //echo "SELECT c.pid,c.title,c.url,c.icon,p.pid as ppid FROM `{$prefix}menu` as c LEFT JOIN `{$prefix}menu` as p ON p.id=c.pid WHERE ( c.id='{$current_menu['pid']}' ) LIMIT 1";
/*
                print_r($current_menu);

                $parent = Menu::get(['id'=>$current_menu->pid])->son();
                //$current_menu['parent'] = $parent;
                print_r($parent);
                exit;
                
                */
                
            }else{
                $current_menu['parent'] = ['pid'=>false,'ppid'=>false];
            }
            $this->assign('current_menu',$current_menu);
            $this->assign('user',$this->user);
        }
    }

    protected function auth(){

        //无需登录页面
        $noNeedLogin = [
            'Login/index','Login/login','Login/verify',//登录
            'Logout/index',//登出
        ];

        //登录后无需验证的页面
        $no_need_to_check = [
            'Upload/uploadpic',//上传显示页
            'Upload/uploadpics',//多图上传显示页
            'Js/js',
            'User/skin',//皮肤切换
        ];

        $status = false;
        $request = \think\Request::instance();
        $this->url = $request->controller().'/'.$request->action();

        //放过无需登录页面
        if(in_array($this->url,$noNeedLogin)){
            return true;
        }

        //登录判断
        $auth = Cookie::get('auth');
        if(!$auth){
            return $this -> error('请先登录',url('admin/login/index'));
        }

        list($identifier, $token) = explode(',', $auth);
        if (ctype_alnum($identifier) && ctype_alnum($token)) {
            $user = User::get(['identifier'=>$identifier,'token'=>$token,'status'=>1]);
            if($user){
                if($token == $user->token && $user->identifier == password($user->uid . md5($user->username . $user->salt))){
                    $status = true;
                }
            }
            $this->user = $user;
        }
        if(!$status){
            return $this -> error('请先登录',url('admin/login/index'));
        }
        if(in_array($this->url,$no_need_to_check)){
            return true;
        }

        //验证页面权限
        $current_url_id = Menu::get(['url'=>$this->url]);
        if(in_array($current_url_id->id,explode(',',$this->user->group->auth))){
            return true;
        }else{
            return $this -> error('您无权访问此页！');
        }
    }

    protected function getMenu($items,$id='id',$pid='pid',$son = 'children'){
        $tree = array();
        $tmpMap = array();

        foreach ($items as $item) {
            $tmpMap[$item[$id]] = $item;
        }

        foreach ($items as $item) {
            if (isset($tmpMap[$item[$pid]])) {
                $tmpMap[$item[$pid]][$son][] = &$tmpMap[$item[$id]];
            }else{
                $tree[] = &$tmpMap[$item[$id]];
            }
        }
        return $tree;
    }
}
