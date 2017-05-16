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

class mariadb {

  # INSTALL MARIADB
  package { "mariadb-server":
    allow_virtual => false,
    provider      => yum,
    ensure        => present
  } ->

  # START MARIADB SERVICE
  service { "mariadb":
    ensure => running,
    enable => true
  } ->

  file { "/tmp/setup.sql":
    source => "puppet:///modules/mariadb/setup.sql",
    mode   => 0644
  } ->

  exec { "run_sql":
    command => "/usr/bin/mysql -uroot < /tmp/setup.sql"
  }
}