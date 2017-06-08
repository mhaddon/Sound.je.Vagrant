# NestedBird  Copyright (C) 2016-2017  Michael Haddon
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License version 3
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class setup_project {

  # CREATE PROJECT STRUCTURE
  file { ["/var/www", "/var/www/sound.dev", "/var/www/sound.dev/logs"]:
    ensure => directory
  } ->

  file { "/var/www/sound.dev/nb_get_pid":
    source => "puppet:///modules/setup_project/nb_get_pid",
    mode   => 0744
  } ->

  file { "/var/www/sound.dev/nb_start":
    source => "puppet:///modules/setup_project/nb_start",
    mode   => 0744
  } ->

  file { "/var/www/sound.dev/nb_stop":
    source => "puppet:///modules/setup_project/nb_stop",
    mode   => 0744
  } ->

  exec { "clone_project_git_repo":
    command => "/usr/bin/git clone https://github.com/mhaddon/Sound.je.git /var/www/sound.dev/source",
    unless  => "/usr/bin/ls /var/www/sound.dev/source"
  } ->

  exec { "check_for_project_git_update":
    command =>
      "/usr/bin/git --work-tree=/var/www/sound.dev/source --git-dir=/var/www/sound.dev/source/.git pull origin master"
  } ->

  exec { "npm_install":
    command =>
      "/usr/bin/npm --prefix /var/www/sound.dev/source install /var/www/sound.dev/source",
    unless => "/usr/bin/ls /var/www/sound.dev/source/node_modules",
    returns => [0, 1, 2, 14]
  } ->

  exec { "npm_install_gulp":
    command =>
      "/usr/bin/npm install gulp -g",
    returns => [0, 1, 2, 14]
  } ->

  exec { "gulp_create_files":
    command =>
      "/usr/bin/cd /var/www/sound.dev/source && /usr/bin/gulp sass && /usr/bin/gulp scripts",
    unless =>
      "/usr/bin/ls /var/www/sound.dev/source/src/main/resources/static/main.js",
    returns => [0, 1, 2, 14]
  } ->

  file { "/var/www/sound.dev/source/src/main/java/com/nestedbird/models/core/DatabaseJunkLoader.java":
    source => "puppet:///modules/setup_project/DatabaseJunkLoader.java",
    mode   => 0644
  } ->

  file { "/var/www/sound.dev/source/src/main/resources/properties/database/database-dev.override.properties":
    source => "puppet:///modules/setup_project/properties/database-dev.override.properties",
    mode   => 0644
  } ->

  file { "/var/www/sound.dev/source/src/main/resources/properties/email/email.override.properties":
    source => "puppet:///modules/setup_project/properties/email.override.properties",
    mode   => 0644
  } ->

  file { "/var/www/sound.dev/source/src/main/resources/properties/application/application.override.properties":
    source => "puppet:///modules/setup_project/properties/application.override.properties",
    mode   => 0644
  } ->

  file { "/var/www/sound.dev/source/src/main/resources/properties/redis/redis-dev.override.properties":
    source => "puppet:///modules/setup_project/properties/redis-dev.override.properties",
    mode   => 0644
  } ->

  package { "java-1.8.0-openjdk":
    allow_virtual => false,
    provider      => yum,
    ensure        => installed
  } ->

  exec { "install_maven_repo":
    command =>
      "/usr/bin/wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo"
  } ->

  package { "apache-maven":
    allow_virtual => false,
    provider      => yum,
    ensure        => installed
  } ->

  exec { "remove_sexy_sexy_unit_tests":
    command =>
      "/usr/bin/rm -rf /var/www/sound.dev/source/src/test/java"
  } ->

  exec { "create_server":
    command =>
      "/usr/bin/mvn -f /var/www/sound.dev/source/pom.xml -q clean compile package",
    returns => [0, 1, 2, 14]
  } ->

  exec { "deploy_newly_build_server":
    command =>
      "/usr/bin/mv /var/www/sound.dev/source/target/NestedBird-1.0.war /var/www/sound.dev/NestedBird.war -f"
  } ->

  exec { "enable_server":
    command =>
      "/usr/bin/sudo sh -c '/usr/bin/echo \"@reboot /var/www/sound.dev/nb_start\" > /etc/cron.d/sound'",
    returns => [0, 1, 2, 14]
  }
}