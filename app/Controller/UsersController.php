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
/**
 * Users Controller
 *
 */
class UsersController extends AppController {  

  public function isAuthorized($user) {
    switch($this->action){
      case 'login':
      case 'logout':
      case 'changepass':
        return true;
        break;
      default:
        return isset($user['role_id']) && $user['role_id'] == 1;
    }
  }

  public function index() {
    $this->User->recursive = 0;
    $this->set('users', $this->paginate());
  }

  public function view($id = null) {
      $this->User->id = $id;
      if (!$this->User->exists()) {
          throw new NotFoundException(__('Invalid user'));
      }
      $this->set('user', $this->User->read(null, $id));
  }

  public function add() {
    if ($this->request->is('post')) {
      $this->User->create();
      if ($this->User->save($this->request->data)) {
        $this->Session->setFlash(__('The user has been saved'));
        $this->redirect(array('action' => 'index'));
      } else {
        $this->Session->setFlash(__('The user could not be saved. Please, try again.'));
      }
    }
    $this->loadModel('Role');
    $this->set('roles', $this->Role->find('list'));
  }  
  
  public function edit($id = null) {
      $this->User->id = $id;
      if (!$this->User->exists()) {
          throw new NotFoundException(__('Invalid user'));
      }
      if ($this->request->is('post') || $this->request->is('put')) {
          if ($this->User->save($this->request->data)) {
              $this->Session->setFlash(__('The user has been saved'));
              $this->redirect(array('action' => 'index'));
          } else {
              $this->Session->setFlash(__('The user could not be saved. Please, try again.'));
          }
      } else {
          $this->request->data = $this->User->read(null, $id);
          unset($this->request->data['User']['password']);
      }
      $this->loadModel('Role');
      $this->set('roles', $this->Role->find('list'));
      $this->render('add');
  }

  public function delete($id = null) {
      if (!$this->request->is('post')) {
          throw new MethodNotAllowedException();
      }
      $this->User->id = $id;
      if (!$this->User->exists()) {
          throw new NotFoundException(__('Invalid user'));
      }
      if ($this->User->delete()) {
          $this->Session->setFlash(__('User deleted'));
          $this->redirect(array('action' => 'index'));
      }
      $this->Session->setFlash(__('User was not deleted'));
      $this->redirect(array('action' => 'index'));
  }
    
    
  public function login() {
    $this->set('title_for_layout', 'Login');
    if ($this->Auth->user()) $this->redirect('/');
    if ($this->request->is('post')) {
      if ($this->Auth->login()) {
        $this->redirect($this->Auth->redirect());
      } else {
        $this->Session->setFlash(__('Invalid username or password, try again'));
      }
    }
  }

  public function logout() {
      $this->redirect($this->Auth->logout());
  }
  
  public function changepass() {
    if ($this->request->is('post')){
      if ($this->request->data['Change Password']['password'] != $this->request->data['Change Password']['password_confirm']){
        $this->Session->setFlash(__('Passwords do not match'));
      } else {
        $user = $this->Auth->user();
        $this->User->read(null, $user['id']);
        $this->User->set('password', $this->request->data['Change Password']['password']);
        $this->User->save();
        $this->Session->setFlash(__('Password changed successfully'));
      }
    }
  }
}
