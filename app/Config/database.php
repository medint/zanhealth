<?php
class DATABASE_CONFIG {

	public $test = array(
		'datasource' => 'Database/Mysql',
		'persistent' => false,
      'host' => 'localhost',
		'login' => '',
		'password' => '',
		'database' => 'zanhealth_test',
		'encoding' => 'utf8'
	);
	public $default = array(
		'datasource' => 'Database/Mysql',
		'persistent' => false,
		'host' => 'us-cdbr-east-04.cleardb.com',
		'login' => 'b3ec4cf5269650',
		'password' => 'dc97910b',
		'database' => 'heroku_06c59c668e56b06',
		'encoding' => 'utf8'
	);
}
