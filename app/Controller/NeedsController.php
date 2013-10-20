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

class NeedsController extends AppController {

  public function isAuthorized($user) {
    switch($this->action){
      case 'upsert':
        return isset($user['role_id']) && in_array($user['role_id'], array(1,2,3));
        break;
      case 'index':
        return true;
        break;
      default:
        return parent::isAuthorized($user);
    }
  }

  public function index(){
    $this->set('title_for_layout', 'View Needs List');
    $this->set('data', $this->Need->find('all'));
    $this->loadModel('Item');
    
    $r = $this->Item->find('all', array('fields' => array('id', 'identifier', 'name', 'status', 'utilization', 'room', 'manufacturer', 'model', 'serial_number')));
    /*$itemdata = array();
    foreach ($r as $i){
      if (!isset($itemdata[$i['Item']['name']])) $itemdata[$i['Item']['name']] = Array();
      $itemdata[$i['Item']['name']][] = $i['Item'];
    }*/
    $itemdata = array('Refrigerator' => array(array('Facility' => array('name' => 'facility'), 'Item' => array('id' => 0, 'identifier' => 'dom-tag/HCEU', 'name' => 'name', 'status' => 'functional', 'utilization' => 'none', 'room' => '0', 'manufacturer' => 'man', 'model' => 'mod', 'serial_number' => 'ser'))));
    $this->set('itemdata', $itemdata);
  }
  
  /*public function requestor(){
    $this->set('title_for_layout', 'View Work Requests');
    if ($this->request->is('post')) $this->redirect(array('..', 'requestor', $_POST['data']['WorkRequest']['requestor']));
    $this->set('requestors', $this->WorkRequest->Requestor->find('list'));
  }
  
  public function facility(){
    $this->set('title_for_layout', 'View Work Requests');
    if ($this->request->is('post')) $this->redirect(array('..', 'facility', $_POST['data']['Facility']['facility']));
    $this->set('facilities', $this->WorkRequest->Item->Facility->find('list'));
  }*/
  
  public function upsert($id = null){
    $this->set('title_for_layout', 'Create Item Request');
    if ($this->request->is('post') || $this->request->is('put')) {
      $this->Need->create();
      if ($this->Need->save($this->request->data)) {
        $this->redirect(array('action' => 'index'));
      } else {
        $this->Session->setFlash(__('The item request could not be saved. Please, try again.'));
      }
    }
    
    $this->set('facilities', $this->Need->Facility->find('list'));
    $this->set('users', $this->Need->User->find('list'));
    
    if ($id) $this->request->data = $this->Need->findById($id);
  }
}
?>