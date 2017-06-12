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

vagrant plugin install vagrant-vbguest &&
rm -rf project &&
printf "\r\n> Cloning project from GitHub\r\n" &&
git clone https://github.com/mhaddon/Sound.je.git project -q &&
printf "\r\n> Downloading NPM Modules\r\n" &&
npm --prefix ./project install ./project --silent &&
rm -rf project/src/test &&
printf "\r\n> Building Maven Project\r\n" &&
mvn -f project/pom.xml -q clean compile package -Dgroups="com.nestedbird.testcategory.Fast,com.nestedbird.testcategory.Slow" &&
printf "\r\n> Build Gulp Projects\r\n" &&
npm --prefix ./project run gulp --silent &&
printf "\r\n> Building Virtual Machine\r\n" &&
vagrant destroy -f &&
vagrant up --provider=virtualbox &&
printf "\r\n> All done :)\r\n"