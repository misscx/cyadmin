<?php

namespace app\admin\model;

use think\Model;

class Menu extends Model
{
    protected $resultSetType = 'collection';
    
    public function son()
    {
        return $this->hasMany('Menu','id','pid');
    }
}