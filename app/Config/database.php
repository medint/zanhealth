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
		'login' => 'be3a194532571b',
		'password' => '6bda2634',
		'database' => 'heroku_782d3780fde94d7',
		'encoding' => 'utf8'
	);
}
