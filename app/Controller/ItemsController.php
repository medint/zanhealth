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

class ItemsController extends AppController {

/**
 * Controller name
 *
 * @var string
 */
	public $name = 'Items';

/**
 * This controller does not use a model
 *
 * @var array
 */
	public $uses = array();
  
  public function isAuthorized($user) {
    switch ($this->action){
      case 'index':
      case 'history':
        return isset($user['role_id']) && in_array($user['role_id'], array(1,2,3,5));
        break;
      case 'upsert':
        return isset($user['role_id']) && in_array($user['role_id'], array(1,2,3));
        break;
      default:
        return parent::isAuthorized($user);
    }
  }
  
  public function index(){
    $this->set('title_for_layout', 'Manage Items');
    $this->set('data', $this->Item->find('all'));
    $this->set('categories', $this->Item->Category->find('list'));
    $this->set('facilities', $this->Item->Facility->find('list'));
    $this->set('vendors', $this->Item->Vendor->find('list'));
  }
  
  public function byName(){
    $this->autoRender = false;
    echo json_encode($this->Item->findAllByName($_GET['name']));
  }
  
  public function history($id){
    $this->loadModel('WorkRequest');
    $this->set('layout_header', false);
    $this->set('data', $this->WorkRequest->find('all', array('conditions' => array('item_id' => $id))));
    $this->render('/WorkRequests/index');
  }
  
  public function upsert($id = null){
    $this->set('title_for_layout', 'Create New Item');
    if ($this->request->is('post') || $this->request->is('put')) {
      $this->Item->create();
      if ($this->Item->save($this->request->data)) {
        $this->redirect(array('action' => 'index'));
      } else {
        $this->Session->setFlash(__('The item could not be saved. Please, try again.'));
      }
    }
    
    $this->set('facilities', $this->Item->Facility->find('list'));
    $this->set('vendors', $this->Item->Vendor->find('list'));
    $this->set('categories', $this->Item->Category->find('list'));
    
    $this->loadModel('WorkRequest');
    $this->set('data', $this->WorkRequest->find('all', array('conditions' => array('item_id' => $id))));
    
    if ($id) $this->request->data = $this->Item->findById($id);
  }
}
?>