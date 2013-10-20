<?php
App::uses('Need', 'Model');

/**
 * Need Test Case
 *
 */
class NeedTest extends CakeTestCase {

/**
 * Fixtures
 *
 * @var array
 */
	public $fixtures = array(
		'app.need',
		'app.facility',
		'app.district',
		'app.zone',
		'app.item',
		'app.vendor',
		'app.category',
		'app.user',
		'app.role'
	);

/**
 * setUp method
 *
 * @return void
 */
	public function setUp() {
		parent::setUp();
		$this->Need = ClassRegistry::init('Need');
	}

/**
 * tearDown method
 *
 * @return void
 */
	public function tearDown() {
		unset($this->Need);

		parent::tearDown();
	}

}
