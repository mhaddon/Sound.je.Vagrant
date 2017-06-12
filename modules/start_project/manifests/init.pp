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

class start_project {
  exec { "deploy_newly_build_server":
    command =>
      "/usr/bin/cp /var/www/sound.dev/source/target/NestedBird-1.0.war /var/www/sound.dev/NestedBird.war"
  } ->
  exec { "force_project_permissions":
    command =>
      "/usr/bin/chown -R vagrant:vagrant /var/www/sound.dev/*"
  } ->
  exec { "wait_a_wee_while":
    command =>
      "/usr/bin/sleep 15"
  } ->
  exec { "start_project_server":
    command => "/var/www/sound.dev/nb_start"
    # unless  => "/var/www/sound.dev/nb_get_pid"
  }
}