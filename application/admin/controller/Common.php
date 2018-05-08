<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：后台公用控制器。
*
**/

namespace app\admin\controller;

use think\Controller;
use think\Config;
use think\Cookie;
use think\Db;
use app\admin\model\User;
use app\admin\model\Menu;
use app\admin\model\Setting;

class Common extends Controller
{
    protected $user = false;
    protected $url;

    public function _initialize()
    {
        $this->auth();//权限验证

        //网站设置
        $setting = Setting::all();
        $config = array();
        foreach ($setting as $k=>$v) {
            $config[$v->k] = $v->v;
        }
        Config::set($config);

        if ($this->user) {
            //菜单
            $menus = Menu::field('id,pid,title,url,icon,tips')->where("status=1 and id in({$this->user->group->auth})")->order('o', 'asc')->select();
            $menu = [];
            foreach ($menus as $key=>$val) {
                $menu[$key]['id'] = $val->id;
                $menu[$key]['pid'] = $val->pid;
                $menu[$key]['title'] = $val->title;
                $menu[$key]['url'] = $val->url;
                $menu[$key]['icon'] = $val->icon;
                $menu[$key]['tips'] = $val->tips;
            }
            $menu = $this->getMenu($menu);

            $current_menu = Menu::name('menu')->field('id,pid,title,url,icon,tips,status')->where(['url'=>$this->url])->find();

            $this->assign('current_menu', $current_menu);
            $this->assign('current_menu_father', $current_menu?$current_menu->father:'');
            $this->assign('menu', $menu);
            $this->assign('user', $this->user);
        }
    }

    protected function auth()
    {

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
        if (in_array($this->url, $noNeedLogin)) {
            return true;
        }

        //登录判断
        $auth = Cookie::get('auth');
        if (!$auth) {
            return $this -> error('请先登录', url('admin/login/index'));
        }

        list($identifier, $token) = explode(',', $auth);
        if (ctype_alnum($identifier) && ctype_alnum($token)) {
            $user = User::get(['identifier'=>$identifier,'token'=>$token,'status'=>1]);
            if ($user) {
                if ($token == $user->token && $user->identifier == password($user->uid . md5($user->username . $user->salt))) {
                    $status = true;
                }
            }
            $this->user = $user;
        }
        if (!$status) {
            return $this -> error('请先登录', url('admin/login/index'));
        }
        if (in_array($this->url, $no_need_to_check)) {
            return true;
        }

        //验证页面权限
        $current_url_id = Menu::get(['url'=>$this->url]);
        if ($current_url_id && in_array($current_url_id->id, explode(',', $this->user->group->auth))) {
            return true;
        } else {
            return $this -> error('您无权访问此页！');
        }
    }

    protected function getMenu($items, $id='id', $pid='pid', $son = 'children')
    {
        $tree = array();
        $tmpMap = array();

        foreach ($items as $item) {
            $tmpMap[$item[$id]] = $item;
        }

        foreach ($items as $item) {
            if (isset($tmpMap[$item[$pid]])) {
                $tmpMap[$item[$pid]][$son][] = &$tmpMap[$item[$id]];
            } else {
                $tree[] = &$tmpMap[$item[$id]];
            }
        }
        return $tree;
    }
}
