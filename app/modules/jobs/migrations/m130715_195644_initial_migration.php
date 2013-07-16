<?php

class m130715_195644_initial_migration extends CDbMigration
{
	public function up()
	{
		$this->createTable('jobs_user', array(
			'id' => 'pk',
			'name' => 'string',
			'email' => 'string',
			'password_hash' => 'string',
			'created_at' => 'integer',
			'updated_at' => 'integer',
		), 'ENGINE=InnoDB');

		$this->createIndex('email_UNIQUE', 'jobs_user', 'email', true);

		$this->createTable('jobs_user_profile', array(
			'user_id' => 'pk',
			'surname' => 'string',
			'icq' => 'string',
			'skype' => 'string',
			'jabber' => 'string',
			'url' => 'string',
			'company' => 'string',
		), 'ENGINE=InnoDB');

		$this->addForeignKey('user', 'jobs_user_profile', 'user_id', 'jobs_user', 'id', 'CASCADE');
		$this->createIndex('user_idx', 'jobs_user_profile', 'user_id');

		$this->createTable('jobs_role', array(
			'id' => 'pk',
			'name' => 'string',
			'created_at' => 'integer',
			'updated_at' => 'integer',
		), 'ENGINE=InnoDB');

		$this->createTable('jobs_job', array(
			'id' => 'pk',
			'title' => 'string',
			'type' => "ENUM('fulltime','contract','freelance')",
			'description' => 'text',
			'text' => 'text',
			'tags' => 'string',
			'price' => 'float',
			'expires' => 'timestamp',
			'created_at' => 'integer',
			'updated_at' => 'integer',
			'status' => 'tinyint UNSIGNED',
			'author_id' => 'integer',
		), 'ENGINE=InnoDB');

		$this->addForeignKey('fk_Job_User1', 'jobs_job', 'author_id', 'jobs_user', 'id', 'NO ACTION');
		$this->createIndex('fk_Job_User1_idx', 'jobs_job', 'author_id');

		$this->createTable('jobs_tag', array(
			'id' => 'pk',
			'title' => 'string',
		), 'ENGINE=InnoDB');

		$this->createIndex('title_UNIQUE', 'jobs_tag', 'title', true);

		$this->createTable('jobs_job_tag', array(
			'job_id' => 'integer',
			'tag_id' => 'integer',
		), 'ENGINE=InnoDB');

		$this->addForeignKey('fk_job_has_tag_job1', 'jobs_job_tag', 'job_id', 'jobs_job', 'id', 'CASCADE', 'NO ACTION');
		$this->addForeignKey('fk_job_has_tag_tag1', 'jobs_job_tag', 'tag_id', 'jobs_tag', 'id', 'CASCADE', 'NO ACTION');
		$this->createIndex('fk_job_has_tag_job1_idx', 'jobs_job_tag', 'job_id');
		$this->createIndex('fk_job_has_tag_tag1_idx', 'jobs_job_tag', 'tag_id');

		$this->createTable('jobs_user_role', array(
			'user_id' => 'integer',
			'role_id' => 'integer',
		), 'ENGINE=InnoDB');

		$this->addForeignKey('fk_user_has_role_user1', 'jobs_user_role', 'user_id', 'jobs_user', 'id', 'CASCADE', 'NO ACTION');
		$this->addForeignKey('fk_user_has_role_role1', 'jobs_user_role', 'role_id', 'jobs_role', 'id', 'CASCADE', 'NO ACTION');
		$this->createIndex('fk_user_has_role_user1_idx', 'jobs_user_role', 'user_id');
		$this->createIndex('fk_user_has_role_role1_idx', 'jobs_user_role', 'role_id');
	}

	public function down()
	{
		$this->dropForeignKey('user', 'jobs_user_profile');
		$this->dropForeignKey('fk_Job_User1', 'jobs_job');
		$this->dropForeignKey('fk_job_has_tag_job1', 'jobs_job_tag');
		$this->dropForeignKey('fk_job_has_tag_tag1', 'jobs_job_tag');
		$this->dropForeignKey('fk_user_has_role_user1', 'jobs_user_role');
		$this->dropForeignKey('fk_user_has_role_role1', 'jobs_user_role');

		$this->dropTable('jobs_user');
		$this->dropTable('jobs_user_profile');
		$this->dropTable('jobs_role');
		$this->dropTable('jobs_job');
		$this->dropTable('jobs_tag');
		$this->dropTable('jobs_job_tag');
		$this->dropTable('jobs_user_role');
	}

	/*
	// Use safeUp/safeDown to do migration with transaction
	public function safeUp()
	{
	}

	public function safeDown()
	{
	}
	*/
}