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

CREATE DATABASE IF NOT EXISTS `NestedBird`;

USE `NestedBird`;

DROP procedure IF EXISTS `getUpcomingEvents`;
DROP procedure IF EXISTS `getMediaByHot`;
DROP function IF EXISTS `getScore`;


source /var/www/sound.dev/source/src/main/resources/sql/procedures/getUpcomingEvents.sql;
source /var/www/sound.dev/source/src/main/resources/sql/procedures/getMediaByHot.sql;
source /var/www/sound.dev/source/src/main/resources/sql/functions/getScore.sql;
