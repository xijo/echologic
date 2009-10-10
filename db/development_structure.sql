CREATE TABLE `concernments` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `tag_id` int(11) default NULL,
  `sort` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_concernments_on_user_id_and_sort` (`user_id`,`sort`),
  KEY `index_concernments_on_sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

CREATE TABLE `interested_people` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `invited_people` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `interested_person_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `locales` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_locales_on_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `organisation` varchar(255) default NULL,
  `position` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `authorizable_type` varchar(40) default NULL,
  `authorizable_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `roles_users` (
  `user_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL auto_increment,
  `value` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;

CREATE TABLE `translations` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(255) default NULL,
  `raw_key` varchar(255) default NULL,
  `value` text,
  `pluralization_index` int(11) default '1',
  `locale_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_translations_on_locale_id_and_key_and_pluralization_index` (`locale_id`,`key`,`pluralization_index`),
  KEY `index_translations_on_locale_id_and_raw_key` (`locale_id`,`raw_key`)
) ENGINE=InnoDB AUTO_INCREMENT=671 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) NOT NULL,
  `crypted_password` varchar(255) default NULL,
  `password_salt` varchar(255) default NULL,
  `persistence_token` varchar(255) NOT NULL,
  `perishable_token` varchar(255) NOT NULL,
  `login_count` int(11) NOT NULL default '0',
  `failed_login_count` int(11) NOT NULL default '0',
  `last_request_at` datetime default NULL,
  `current_login_at` datetime default NULL,
  `last_login_at` datetime default NULL,
  `current_login_ip` varchar(255) default NULL,
  `last_login_ip` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `active` tinyint(1) NOT NULL default '0',
  `openid_identifier` varchar(255) default NULL,
  `picture_file_name` varchar(255) default NULL,
  `picture_content_type` varchar(255) default NULL,
  `picture_file_size` int(11) default NULL,
  `picture_updated_at` datetime default NULL,
  `name` varchar(255) default NULL,
  `prename` varchar(255) default NULL,
  `gender` tinyint(1) default NULL,
  `about_me` text,
  `motivation` text,
  `city` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `web_profiles` (
  `id` int(11) NOT NULL auto_increment,
  `sort` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_web_profiles_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20090811104555');

INSERT INTO schema_migrations (version) VALUES ('20090812170351');

INSERT INTO schema_migrations (version) VALUES ('20090825095800');

INSERT INTO schema_migrations (version) VALUES ('20090825170636');

INSERT INTO schema_migrations (version) VALUES ('20090827052026');

INSERT INTO schema_migrations (version) VALUES ('20090827071723');

INSERT INTO schema_migrations (version) VALUES ('20090827072846');

INSERT INTO schema_migrations (version) VALUES ('20090827160621');

INSERT INTO schema_migrations (version) VALUES ('20090829092843');

INSERT INTO schema_migrations (version) VALUES ('20090912071928');

INSERT INTO schema_migrations (version) VALUES ('20090915070848');

INSERT INTO schema_migrations (version) VALUES ('20090915133056');

INSERT INTO schema_migrations (version) VALUES ('20090924125806');

INSERT INTO schema_migrations (version) VALUES ('20090930145231');

INSERT INTO schema_migrations (version) VALUES ('20090930184501');

INSERT INTO schema_migrations (version) VALUES ('20091008104532');