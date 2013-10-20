<?php
/**
 * Routes configuration
 *
 * In this file, you set up routes to your controllers and their actions.
 * Routes are very important mechanism that allows you to freely connect
 * different urls to chosen controllers and their actions (functions).
 *
 * PHP 5
 *
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright 2005-2012, Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @package       app.Config
 * @since         CakePHP(tm) v 0.2.9
 * @license       MIT License (http://www.opensource.org/licenses/mit-license.php)
 */
/**
 * Here, we are connecting '/' (base path) to controller called 'Pages',
 * its action called 'display', and we pass a param to select the view file
 * to use (in this case, /app/View/Pages/home.ctp)...
 */
	Router::connect('/', array('controller' => 'pages', 'action' => 'home', 'home'));
/**
 * ...and connect the rest of 'Pages' controller's urls.
 */
	Router::connect('/pages/*', array('controller' => 'pages', 'action' => 'display'));
  
  //Router::connect('/config/user', array('controller' => 'users', 'action' => 'index'));
  //Router::connect('/config/users', array('controller' => 'users', 'action' => 'index'));
  //Router::connect('/config/User/add', array('controller' => 'users', 'action' => 'add'));
  //Router::connect('/config/User/update', array('controller' => 'users', 'action' => 'edit'));
  //Router::connect('/users/edit/:id', array('controller' => 'users', 'action' => 'edit'), array('pass' => array('id')));
  Router::connect('/users', array('controller' => 'config', 'action' => 'index', 'users'));
  Router::connect('/config/:key/find', array('controller' => 'config', 'action' => 'find', '[method]' => 'POST'), array('pass' => array('key')));
  Router::connect('/config/:key/create', array('controller' => 'config', 'action' => 'create', '[method]' => 'POST'), array('pass' => array('key')));
  Router::connect('/config/:key/update', array('controller' => 'config', 'action' => 'update', '[method]' => 'POST'), array('pass' => array('key')));
  Router::connect('/config/:key/delete', array('controller' => 'config', 'action' => 'delete', '[method]' => 'POST'), array('pass' => array('key')));
  Router::connect('/config/:key', array('controller' => 'config', '[method]' => 'GET'), array('pass' => array('key')));
  Router::connect('/config/:key', array('controller' => 'config', 'action' => 'apply', '[method]' => 'POST'));
  
  Router::connect('/workRequests/create', array('controller' => 'workRequests', 'action' => 'upsert'));
  Router::connect('/workRequests/edit/:id', array('controller' => 'workRequests', 'action' => 'upsert'), array('pass' => array('id')));
  Router::connect('/workRequests/:prop/:value/*', array('controller' => 'workRequests', 'action' => 'index'), array('pass' => array('prop', 'value')));
  
  Router::connect('/needs/create', array('controller' => 'needs', 'action' => 'upsert'));
  Router::connect('/needs/edit/:id', array('controller' => 'needs', 'action' => 'upsert'), array('pass' => array('id')));
  
  Router::connect('/items/create', array('controller' => 'items', 'action' => 'upsert'));
  Router::connect('/items/edit/:id', array('controller' => 'items', 'action' => 'upsert'), array('pass' => array('id')));

/**
 * Load all plugin routes.  See the CakePlugin documentation on
 * how to customize the loading of plugin routes.
 */
	CakePlugin::routes();

/**
 * Load the CakePHP default routes. Only remove this if you do not want to use
 * the built-in default routes.
 */
	require CAKE . 'Config' . DS . 'routes.php';
