<?php

use think\migration\Migrator;
use think\migration\db\Column;

class Setting extends Migrator
{
    /**
     * Change Method.
     *
     * Write your reversible migrations using this method.
     *
     * More information on writing migrations is available here:
     * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
     *
     * The following commands can be used in this method and Phinx will
     * automatically reverse them when rolling back:
     *
     *    createTable
     *    renameTable
     *    addColumn
     *    renameColumn
     *    addIndex
     *    addForeignKey
     *
     * Remember to call "create()" or "update()" and NOT "save()" when working
     * with the Table class.
     */
    public function up()
    {
        $table = $this->table('setting', array('id'=>false,'primary_key'=>array('k'),'engine'=>'MyISAM'));
        $table->addColumn('k', 'string', array('limit' => 255,'default'=>'','comment'=>'变量名称'))
            ->addColumn('v', 'string', array('limit' => 255,'default'=>'','comment'=>'变量值'))
            ->addColumn('name', 'string', array('limit' => 255,'default'=>'','comment'=>'名称'))
            ->addColumn('tips', 'string', array('limit' => 255,'default'=>'','comment'=>'提示信息'))
            ->addColumn('type', 'boolean', array('limit' => 1,'default'=>1,'comment'=>'类型，0系统，1自定义'))
            ->addColumn('o', 'integer', array('limit' => 11,'default'=>0,'comment'=>'排序，越小越靠前'))
            ->addIndex(array('o'))
            ->create();

        $rows = array(
                    array(
                        'k'=>'title',
                        'v'=>'春燕网络通用后台管理系统',
                        'name'=>'网站名称',
                        'tips'=>'长度255个汉字内',
                        'type'=>0,
                        'o'=>0,
                    ),
                    array(
                        'k'=>'sitename',
                        'v'=>'CYAdmin',
                        'name'=>'',
                        'tips'=>'长度255个汉字内',
                        'type'=>0,
                        'o'=>0,
                    ),
                    array(
                        'k'=>'keywords',
                        'v'=>'关键词',
                        'name'=>'关键词',
                        'tips'=>'长度255个汉字内',
                        'type'=>0,
                        'o'=>0,
                    ),
                    array(
                        'k'=>'description',
                        'v'=>'网站描述',
                        'name'=>'网站描述',
                        'tips'=>'长度255个汉字内',
                        'type'=>0,
                        'o'=>0,
                    ),
                    array(
                        'k'=>'footer',
                        'v'=>'&copy;2016 春燕网络',
                        'name'=>'版权信息',
                        'tips'=>'长度255个汉字内',
                        'type'=>0,
                        'o'=>0,
                    ),
                );

        $this->insert('setting', $rows);
    }

    public function down()
    {
        $this->dropTable('setting');
    }
}
