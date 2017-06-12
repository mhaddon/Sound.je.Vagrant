#!/usr/bin/env bash

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

printf "\r\n> Building Maven Project\r\n" &&
mvn -f project/pom.xml -q clean compile package -Dgroups="com.nestedbird.testcategory.Fast,com.nestedbird.testcategory.Slow" &&
printf "\r\n> Build Gulp Projects\r\n" &&
npm --prefix ./project run gulp &&
printf "\r\n> Restarting Server\r\n" &&
vagrant provision --provision-with build &&
vagrant provision --provision-with shell &&
printf "\r\n> All done :)\r\n"