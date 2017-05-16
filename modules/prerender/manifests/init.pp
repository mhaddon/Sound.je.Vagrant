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

class prerender {

  # CREATE PROJECT STRUCTURE

  file { "/var/www/sound.dev/logs/prerender":
    ensure => directory
  } ->

  exec { "clone_prerender_git_repo":
    command => "/usr/bin/git clone https://github.com/prerender/prerender.git /var/www/sound.dev/prerender",
    unless  => "/usr/bin/ls /var/www/sound.dev/prerender"
  } ->

  exec { "check_for_prerender_git_update":
    command =>
      "/usr/bin/git --work-tree=/var/www/sound.dev/prerender --git-dir=/var/www/sound.dev/prerender/.git pull origin master"
  } ->

  file { "/var/www/sound.dev/prerender/pr_get_pid":
    source => "puppet:///modules/prerender/pr_get_pid",
    mode   => 0744
  } ->

  file { "/var/www/sound.dev/prerender/pr_start":
    source => "puppet:///modules/prerender/pr_start",
    mode   => 0744
  } ->

  file { "/var/www/sound.dev/prerender/pr_stop":
    source => "puppet:///modules/prerender/pr_stop",
    mode   => 0744
  } ->

  exec { "start_prerender_server":
    command => "/var/www/sound.dev/prerender/pr_start",
    unless  => "/var/www/sound.dev/prerender/pr_get_pid"
  }
}