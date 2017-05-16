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

class nginx {

  # INSTALL NGINX
  package { "nginx":
    allow_virtual => false,
    provider      => yum,
    ensure        => present
  } ->

  # INSTALL NGINX CONFIGURATION
  file { "/etc/nginx/conf.d":
    path    => "/etc/nginx/conf.d",
    ensure  => directory,
    source  => "puppet:///modules/nginx/conf.d",
    force   => true,
    recurse => true,
    purge   => true
  } ->

  # START NGINX SERVICE
  service { "nginx":
    ensure => running,
    enable => true
  }
}