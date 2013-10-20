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

class WorkRequestsController extends AppController {
  public function isAuthorized($user) {
    switch($this->action){
      case 'upsert':
        return isset($user['role_id']) && in_array($user['role_id'], array(1,3));
        break;
      case 'index':
      case 'reports':
        return isset($user['role_id']) && in_array($user['role_id'], array(1,2,3,5));
      default:  
        return parent::isAuthorized($user);
    }
  }
  
  public function index($prop = 'Status', $value = 'Open'){
    $value = implode('/', array_merge(array($value), array_slice(func_get_args(), 2)));
    $this->set('title_for_layout', 'View Work Requests');
    switch($prop){
      case 'requestor':
        $prop .= '_id';
        // fall through
      case 'Status':
        $this->set('data', $this->WorkRequest->{'findAllBy'.$prop}($value));
        break;
      case 'facility':
      case 'vendor':
        $prop .= '_id';
      default:
        $this->set('data', $this->WorkRequest->find('all', array(
          'conditions' => array( 'Item.' . $prop => $value ),
          'contain' => 'Item.' . $prop
        )));
    }
  }
  
  public function reports(){
    $this->set('title_for_layout', 'View Work Requests');
    if ($this->request->is('post')){
      $prop = strtolower(Inflector::slug(str_replace('Search By ', '', $_POST['submit'])));
      switch($prop){
        case 'facility':
          $this->redirect(array('..', 'facility', $_POST['data']['Facility']['facility']));
          break;
        case 'vendor':
          $this->redirect(array('..', 'vendor', $_POST['data']['Vendor']['vendor']));
          break;
        case 'work_request':
          $this->redirect(array('..', 'requestor', $_POST['data']['WorkRequest']['requestor']));
          break;
        case 'asset_name':
          $this->redirect(array('..', 'name', $_POST['data']['WorkRequest'][$prop]));
          break;
        default:
          $this->redirect(array('..', $prop, $_POST['data']['WorkRequest'][$prop]));
      }
    }
    
    
    $this->set('requestors', $this->WorkRequest->Requestor->find('list'));
  
    $this->set('facilities', $this->WorkRequest->Item->Facility->find('list'));
    
    $this->set('vendors', $this->WorkRequest->Item->Vendor->find('list'));
    
    $asset_name = $this->WorkRequest->Item->find('list', array('fields' => 'name', 'group' => 'name'));
    foreach($asset_name as $k => $v){
      if ($v) $asset_name[$v] = $v;
      unset($asset_name[$k]);
    }
    $this->set('asset_name', $asset_name);
  
    $manufacturers = $this->WorkRequest->Item->find('list', array('fields' => 'manufacturer', 'group' => 'manufacturer'));
    foreach($manufacturers as $k => $v){
      if ($v) $manufacturers[$v] = $v;
      unset($manufacturers[$k]);
    }
    $this->set('manufacturers', $manufacturers);
    
    $rooms = $this->WorkRequest->Item->find('list', array('fields' => 'room', 'group' => 'room'));
    foreach($rooms as $k => $v){
      if ($v) $rooms[$v] = $v;
      unset($rooms[$k]);
    }
    $this->set('rooms', $rooms);
    
    $utilizations = $this->WorkRequest->Item->find('list', array('fields' => 'utilization', 'group' => 'utilization'));
    foreach($utilizations as $k => $v){
      if ($v) $utilizations[$v] = $v;
      unset($utilizations[$k]);
    }
    $this->set('utilizations', $utilizations);
  }
  
  public function upsert($id = null){
    $this->set('title_for_layout', 'Create Work Request');
    if ($this->request->is('post') || $this->request->is('put')) {
      $this->WorkRequest->create();
      if ($this->WorkRequest->save($this->request->data)) {
        $this->redirect(array('action' => 'index'));
      } else {
        $this->Session->setFlash(__('The work request could not be saved. Please, try again.'));
      }
    }
    $this->set('workPriorities', $this->WorkRequest->WorkPriority->find('list'));
    $this->set('workTrades', $this->WorkRequest->WorkTrade->find('list'));
    $this->set('requestors', $this->WorkRequest->Requestor->find('list'));
    $this->set('items', $this->WorkRequest->Item->find('list'));
    
    if ($id) $this->request->data = $this->WorkRequest->findById($id);
  }
}
?>