<?
/**************************************************************************\
* Copyright 2013 Ryan Chan <ryan@rcchan.com>                               *
*                                                                          *
* This program is free software: you can redistribute it and/or modify     *
* it under the terms of the GNU Affero General Public License as           *
* published by the Free Software Foundation, either version 3 of the       *
* License, or (at your option) any later version.                          *
*                                                                          *
* This program is distributed in the hope that it will be useful,          *
* but WITHOUT ANY WARRANTY; without even the implied warranty of           *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
* GNU Affero General Public License for more details.                      *
*                                                                          *
* You should have received a copy of the GNU Affero General Public License *
* along with this program.  If not, see <http://www.gnu.org/licenses/>.    *
*                                                                          *
*                                                                          *
* Additional permission under the GNU Affero GPL version 3 section 7:      *
*                                                                          *
* If you modify this Program, or any covered work, by linking or           *
* combining it with other code, such other code is not for that reason     *
* alone subject to any of the requirements of the GNU Affero GPL           *
* version 3.                                                               *
\**************************************************************************/
?>
<?php
App::uses('AppController', 'Controller');

class ConfigController extends AppController {

/**
 * Controller name
 *
 * @var string
 */
	public $name = 'Config';
  public $uses = array('Zone', 'District', 'Facility', 'User', 'Vendor', 'Category', 'WorkPriority', 'WorkTrade');
  
  public function isAuthorized($user) {
    return isset($user['role_id']) && $user['role_id'] == 1;
  }
  public function index($key = NULL){
    $this->set('title_for_layout', $key ? 'Manage ' . Inflector::humanize(Inflector::pluralize($key)) : 'Config System');
    if ($key){
      $model = Inflector::classify($key);
      $this->set('key', $key);
      $this->set('model', $model);
      
      $typemap = array(
        'string' => 'text',
        'datetime' => 'date',
        'integer' => 'text'
      );
      
      $fields = $this->{$model}->getColumnTypes();
      foreach($fields as $k => &$v){
        $fields[$k] = array('title' => $k, 'type' => $typemap[$v], 'key' => $k == 'id');
      }
      $this->set('fields', $fields);
      $this->set('isUserConfig', $model == 'User');
    }
  }
  
  public function find($key = NULL){
    $this->autoRender = false;
    if($key){
      $model = Inflector::classify($key);
      $data = $this->{$model}->find('all', array('recursive'=>false));
      foreach($data as &$d){
        foreach($d as $k => &$f){
          if (isset($f['username'])) $f['username'] = '<a href="' . Router::url(array('controller' => 'users', 'action' => 'edit', $f['id'])) . '">' . $f['username'] . '</a>';
          if (isset($f['password'])) $f['password'] = '[password encrypted]';
          if ($k != $model){
            $d[$model][strtolower($k) . '_id'] = $d[$k]['name'];
            unset($d[$k]);
          }
        }
        $d = $d[$model];
      }
      echo json_encode(array(
        'Result' => 'OK',
        'Records' => $data
      ));
    } else echo json_encode(array('Result' => 'ERROR', 'Message' => 'No key provided'));
  }
  
  public function create($key = NULL){
    $this->autoRender = false;
    if($key){
      $model = Inflector::classify($key);
      $d = $this->{$model}->save($_POST);
      if ($d){
        foreach($d as $k => &$f){
          if ($k != $model){
            $d[$model][strtolower($k) . '_id'] = $d[$k]['name'];
            unset($d[$k]);
          }
        }
        $d = $d[$model];
      }
      
      echo json_encode($d ? array(
        'Result' => 'OK',
        'Record' => $d
      ) : array(
        'Result' => 'ERROR',
        'Message' => 'Could not save data'
      ));
    } else echo json_encode(array('Result' => 'ERROR', 'Message' => 'No key provided'));
  }
  
  public function update($key = NULL){
    $this->autoRender = false;
    if($key){
      $model = Inflector::classify($key);
      $d = $this->{$model}->save($_POST);
      
      echo json_encode($d ? array(
        'Result' => 'OK',
        'Record' => $d
      ) : array(
        'Result' => 'ERROR',
        'Message' => 'Could not save data'
      ));
    } else echo json_encode(array('Result' => 'ERROR', 'Message' => 'No key provided'));
  }
  
  public function delete($key = NULL){
    $this->autoRender = false;
    if($key){
      $model = Inflector::classify($key);
      $d = $this->{$model}->delete($_POST['id']);
      
      echo json_encode(array('Result' => 'OK'));
    } else echo json_encode(array('Result' => 'ERROR', 'Message' => 'No key provided'));
  }
  
  public function apply($key = NULL){
    echo 'POST '.$key;
  }
}
