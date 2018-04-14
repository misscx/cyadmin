<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-10-28
* 功能说明：用户管理控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use think\Db;
use think\facade\Request;

class User extends Common
{
    public function index($act = null, $uid=0)
    {
        if ($act=='edit') {
            $uid = intval($uid);
            $userinfo = Db::name('user')->where(['uid'=>$uid])->find();
            if (!$userinfo) {
                return $this->error('参数错误，请重试！');
            }
            $this->assign('userinfo', $userinfo);

            $group = Db::name('user_group')->field('id,title')->where(['status'=>1])->select();
            $this->assign('group', $group);

            return $this->fetch('form');
        }

        if ($act == 'add') {
            $group = Db::name('user_group')->field('id,title')->where(['status'=>1])->select();
            $this->assign('group', $group);
            return $this->fetch('form');
        }

        if ($act == 'update') {
            if (!Request::isPost()) {
                return $this->error('参数错误，请重试！');
            }
            $uid = intval($uid);
            $data = input('post.');
            $data['birthday'] = strtotime($data['birthday']);
            if (!isset($data['status'])) {
                $data['status'] = 0;
            }
            if (Db::name('user')->where(['uid'=>$uid])->count()==0) {//新增
                if ($data['username']=='') {
                    return $this->error('用户名不能为空！');
                }
                if ($data['password']=='') {
                    return $this->error('用户密码不能为空！');
                }
                if (Db::name('user')->where(['username'=>$data['username']])->count()>0) {
                    return $this->error('用户名已被占用，请重试！');
                }

                $data['password'] = password($data['password']);
                $r = Db::name('user')->insert($data);
                if ($r) {
                    addlog('新增用户，用户名：'.$data['username'], $this->user['username']);
                    return $this->success('恭喜，新增用户成功！', url('admin/user/index'));
                }
            } else {//编辑
                if ($data['password']=='') {
                    unset($data['password']);
                } else {
                    $data['password'] = password($data['password']);
                }
                $r = Db::name('user')->where(['uid'=>$uid])->update($data);
                if ($r) {
                    addlog('修改用户信息，UID：'.$uid, $this->user['username']);
                    return $this->success('恭喜，修改用户成功！', url('admin/user/index'));
                }
            }
            return $this->error('参数错误，请重试！');
        }

        if ($act == 'del') {
            if (!Request::isPost()) {
                return $this->error('参数错误，请重试！');
            }
            $uids = input('post.');
            if (empty($uids)) {
                return $this->error('请选择要删除的用户！');
            }
            $uids = $uids['uids'];
            $r = Db::name('user')->delete($uids);
            if ($r) {
                addlog('删除用户，UID：'.implode(',', $uids), $this->user['username']);
                return $this->error('用户删除成功！', url('admin/user/index'));
            } else {
                return $this->error('请选择要删除的用户！');
            }
        }

        $list = Db::name('user')->alias('u')->join('__USER_GROUP__ g', 'g.id=u.ugid', 'left')->field('u.uid,u.ugid,u.username,u.status,u.sex,u.birthday,u.tel,u.qq,u.email,g.title')->order('u.uid desc')->paginate(25);
        $this->assign('list', $list);
        return $this->fetch();
    }

    public function skin($skin=null)
    {
        if ($skin=='skin-1') {
            $skin = 'skin-1';
        } elseif ($skin=='skin-2') {
            $skin = 'skin-2';
        } elseif ($skin=='skin-3') {
            $skin = 'skin-3 no-skin';
        } else {
            $skin = 'no-skin';
        }
        Db::name('user')->where(['uid'=>$this->user['uid']])->update(['skin'=>$skin]);
        die('1');
    }
}
