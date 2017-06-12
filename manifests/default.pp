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

# execute yum update
exec { "yum_update":
  command => "/bin/yum -y -q update"
} ->

# INSTALL EPEL-RELEASE REPOSITORY
package { "epel-release":
  allow_virtual => false,
  provider      => yum,
  ensure        => present
} ->

# INSTALL GIT
package { "git":
  allow_virtual => false,
  provider      => yum,
  ensure        => present
} ->

# INSTALL WGET
package { "wget":
  allow_virtual => false,
  provider      => yum,
  ensure        => present
} ->

# INSTALL NODE
package { "nodejs":
  allow_virtual => false,
  provider      => yum,
  ensure        => present
} ->

# DISABLE FIREWALL
service { "firewalld":
  ensure => stopped,
  enable => false
} ->

# Create Project Setup
class { "setup_project": } ->

class { "mariadb": } ->

class { "prerender": } ->

class { "nginx": } ->

class { "redis": } ->

class { "build_project": } ->

class { "start_project": }