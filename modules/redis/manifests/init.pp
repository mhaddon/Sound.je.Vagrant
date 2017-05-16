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

class redis {

  # INSTALL REDIS
  package { "redis":
    allow_virtual => false,
    provider      => yum,
    ensure        => present
  } ->

  exec { "configure_redis_password":
    command => "/usr/bin/echo 'requirepass secret' >> /etc/redis.conf"
  } ->

  # START REDIS SERVICE
  service { "redis":
    ensure => running,
    enable => true
  } ->

  exec { "clear_redis_store":
    command => "/usr/bin/redis-cli -a secret flushall"
  }
}