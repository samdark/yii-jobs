<?php
class JobsModule extends CWebModule
{
	/**
	 * @var array Auth adapter config
	 */
	public $authAdapter = array(
		'class' => 'YiiJobAuth',
	);

	/**
	 * @var array Search adapter config
	 */
	public $searchAdapter = array(

	);

	/**
	 * @var array User adapter config
	 */
	public $userAdapter = array(

	);

	public function init()
	{
		// import the module-level models and components
		$this->setImport(array(
			'jobs.models.*',
			'jobs.components.*',
		));

		/** @var $cs CClientScript */
		$cs = Yii::app()->clientScript;

		if(!isset($cs->packages['jobs']))
		{
			$cs->addPackage('jobs',array(
				'basePath' => 'jobs.assets',
				'depends' => array('jquery'),
				'css' => array('jobs.css'),
				'js' => array('jobs.js'),
			));
		}
		$cs->registerPackage('jobs');
	}

	/**
	 * @var IJobsAuth
	 */
	private $_auth;

	/**
	 * @return IJobsAuth
	 */
	public function getAuth()
	{
		Yii::import('jobs.components.auth.*');
		if($this->_auth===null) {
			$this->_auth = Yii::createComponent($this->authAdapter);
		}
		return $this->_auth;
	}

	/**
	 * @var IJobsUser
	 */
	private $_userAdapter;
	public function getUser()
	{
		Yii::import('jobs.components.user.*');
		if($this->_userAdapter===null) {
			$this->_userAdapter = Yii::createApplication($this->userAdapter);
		}
		return $this->_userAdapter;
	}
}
