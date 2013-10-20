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
App::uses('AppModel', 'Model');
/**
 * WorkRequest Model
 *
 * @property WorkPriority $WorkPriority
 * @property Item $Item
 * @property WorkTrade $WorkTrade
 * @property Requestor $Requestor
 */
class WorkRequest extends AppModel {

/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'date' => array(
			'datetime' => array(
				'rule' => array('datetime'),
				'message' => 'Invalid date/time',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'expire' => array(
			'datetime' => array(
				'rule' => array('datetime'),
				'message' => 'Invalid date/time',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'completed' => array(
			'datetime' => array(
				'rule' => array('datetime'),
				'message' => 'Invalid date/time',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'work_priority_id' => array(
			'naturalnumber' => array(
				'rule' => array('naturalnumber'),
				'message' => 'Invalid id provided',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'item_id' => array(
			'naturalnumber' => array(
				'rule' => array('naturalnumber'),
				'message' => 'Not a valid item',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'work_trade_id' => array(
			'naturalnumber' => array(
				'rule' => array('naturalnumber'),
				'message' => 'Invalid work trade',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
		'requestor_id' => array(
			'naturalnumber' => array(
				'rule' => array('naturalnumber'),
				'message' => 'Not a valid user',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),
	);

	//The Associations below have been created with all possible keys, those that are not needed can be removed

/**
 * belongsTo associations
 *
 * @var array
 */
	public $belongsTo = array(
		'WorkPriority' => array(
			'className' => 'WorkPriority',
			'foreignKey' => 'work_priority_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		),
		'Item' => array(
			'className' => 'Item',
			'foreignKey' => 'item_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		),
		'WorkTrade' => array(
			'className' => 'WorkTrade',
			'foreignKey' => 'work_trade_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		),
		'Requestor' => array(
			'className' => 'User',
			'foreignKey' => 'requestor_id',
			'conditions' => '',
			'fields' => '',
			'order' => ''
		)
	);
}
