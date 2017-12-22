<?php

namespace app\admin\model;

use think\Model;

class User extends Model
{
    public function group()
    {
        return $this->hasOne('UserGroup','id','ugid');
    }
}