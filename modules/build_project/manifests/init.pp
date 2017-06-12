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

class build_project {
  exec { "stop_server":
    command =>
      "/var/www/sound.dev/nb_stop",
    returns => [0, 1, 2, 14]
  }

  # exec { "create_server":
  #   command =>
  #     "/usr/bin/mvn -f /var/www/sound.dev/source/pom.xml -q clean compile package",
  #   returns => [0, 1, 2, 14]
  # }
}
