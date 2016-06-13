<?php
/**
*
* 版权所有：春燕网络<www.mychunyan.com>
* 作    者：寒川<admin@huikon.cn>
* 日    期：2016-06-12
* 功能说明：数据备分控制器。
*
**/

namespace app\admin\Controller;

use app\admin\controller\Common;
use \think\Db;
use \think\Input;
use \think\Config;
use org\Data;

class Database extends Common {

    public function backup($act = null) {
		
		if($act == 'export'){

			//$tables = null, $id = null, $start = null
			$tables = Input::post();
			$id = Input::get('id/d');
			$start = Input::get('start/d');

			if(!empty($tables)){
				$tables = $tables['tables'];
			}

			if(!empty($tables)){//初始化
				//读取备份配置
				$config = array(
					'path'     => realpath(Config::get('DB_PATH')) . DIRECTORY_SEPARATOR,  //路径
					'part'     => Config::get('DB_PART'),  //分卷大小 20M
					'compress' => Config::get('DB_COMPRESS'),  //0:不压缩 1:启用压缩
					'level'    => Config::get('DB_LEVEL'),  //压缩级别, 1:普通 4:一般  9:最高
				);
				//检查是否有正在执行的任务
				$lock = "{$config['path']}backup.lock";
				if(is_file($lock)){
					return $this->error('检测到有一个备份任务正在执行，请稍后再试！');
				} else {
					//创建锁文件
					file_put_contents($lock, time());
				}

				//检查备份目录是否可写 创建备份目录
				is_writeable($config['path']) || mkdir('./'.C("DB_PATH_NAME").'',0777,true);
				session('backup_config', $config);

				//生成备份文件信息
				$file = array(
					'name' => date('Ymd-His', time()),
					'part' => 1,
				);
				session('backup_file', $file);

				//缓存要备份的表
				session('backup_tables', $tables);

				//创建备份文件
				$Database = new Data($file, $config);
				if(false !== $Database->create()){
					$tab = array('id' => 0, 'start' => 0);
					//return $this->success('初始化成功！', '', array('tables' => $tables, 'tab' => $tab));
					echo '{"tables":["cy_log","cy_menu","cy_setting","cy_user","cy_user_group"],"tab":{"id":0,"start":0},"info":"\u521d\u59cb\u5316\u6210\u529f\uff01","status":1,"url":""}';
					
					return;
				} else {
					return $this->error('初始化失败，备份文件创建失败！');
				}
			} elseif (is_numeric($id) && is_numeric($start)) { //备份数据
				$tables = session('backup_tables');
				//备份指定表
				$Database = new Data(session('backup_file'), session('backup_config'));
				$start  = $Database->backup($tables[$id], $start);
				if(false === $start){ //出错
					$this->error('备份出错！');
				} elseif (0 === $start) { //下一表
					if(isset($tables[++$id])){
						$tab = array('id' => $id, 'start' => 0);
						$this->success('备份完成！', '', array('tab' => $tab));
					} else { //备份完成，清空缓存
						unlink(session('backup_config.path') . 'backup.lock');
						session('backup_tables', null);
						session('backup_file', null);
						session('backup_config', null);
						addlog('备份完成！',$this->user['username']);
						$this->success('备份完成！');
					}
				} else {
					$tab  = array('id' => $id, 'start' => $start[0]);
					$rate = floor(100 * ($start[0] / $start[1]));
					$this->success("正在备份...({$rate}%)", '', array('tab' => $tab));
				}
					
			} else { //出错
				$this->error('参数错误！');
			}
			
			
		}
		
		$list  = Db::query('SHOW TABLE STATUS');
		$list  = array_map('array_change_key_case', $list);
		$this->assign('list', $list);
		return $this->fetch();
    }

}