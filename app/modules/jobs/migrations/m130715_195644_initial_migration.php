<?php
class m130715_195644_initial_migration extends CDbMigration
{
	public function up()
	{
		// MySQL-specific table options. Adjust if you plan working with another DBMS
		$tableOptions = 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB';

		$this->createTable('jobs_profile', array(
			'user_id' => 'integer',
			'icq' => 'string',
			'skype' => 'string',
			'jabber' => 'string',
			'url' => 'string',
			'company' => 'string',
		), $tableOptions);

		$this->addForeignKey('fk-jobs_profile-user_id', 'jobs_profile', 'user_id', 'jobs_user', 'id', 'CASCADE');

		$this->createTable('jobs_job', array(
			'id' => 'pk',
			'title' => 'string',
			'type' => 'tinyint NOT NULL DEFAULT 10',
			'description' => 'text',
			'tags' => 'string',
			'price' => 'float',
			'price_from' => 'float',
			'price_to' => 'float',
			'expire_time' => 'integer',
			'create_time' => 'integer',
			'update_time' => 'integer',
			'status' => 'tinyint NOT NULL DEFAULT 10',
			'author_id' => 'integer',
		), $tableOptions);

		$this->addForeignKey('fk-jobs_job-author_id', 'jobs_job', 'author_id', 'jobs_user', 'id');

		$this->createTable('jobs_tag', array(
			'id' => 'pk',
			'name' => 'string',
		), $tableOptions);

		$this->createIndex('idx-jobs_tag-name-unique', 'jobs_tag', 'name', true);

		$this->createTable('jobs_job_tag', array(
			'job_id' => 'integer',
			'tag_id' => 'integer',
			'PRIMARY KEY (job_id, tag_id)'
		), $tableOptions);

		$this->addForeignKey('fk-jobs_job_tag-job_id', 'jobs_job_tag', 'job_id', 'jobs_job', 'id', 'CASCADE');
		$this->addForeignKey('fk-jobs_job_tag-tag_id', 'jobs_job_tag', 'tag_id', 'jobs_tag', 'id', 'CASCADE');
	}

	public function down()
	{
		$this->dropForeignKey('fk-jobs_profile-user_id', 'jobs_profile');
		$this->dropForeignKey('fk-jobs_job-author_id', 'jobs_job');
		$this->dropForeignKey('fk-jobs_job_tag-job_id', 'jobs_job_tag');
		$this->dropForeignKey('fk-jobs_job_tag-tag_id', 'jobs_job_tag');

		$this->dropTable('jobs_profile');
		$this->dropTable('jobs_job');
		$this->dropTable('jobs_tag');
		$this->dropTable('jobs_job_tag');
	}
}