## NestedBird Virtual Server - Sound.je
##### VERSION: 1.0.0

This project contains the code to create a development and testing environment for the NestedBird/Sound of Jersey project. 

This project pulls the publicly released source code of https://www.sound.je which can be found at: https://github.com/mhaddon/Sound.je/ and sets up a Centos 7 virtual server to build and run the server.

The building of the server is managed using Vagrant and Puppet. If you want a more personalised solution then you can simply install the server however you like, just following the specifications that Puppet follows. This project is mostly an example of how to set up the project, and a version you can easily clone if you want to mess around quickly.

Support of any kind is not guarenteed and if you are running the software to set up the project, it is advised that you already know what you are doing.

This is an OpenSource project licensed under GNU Affero General Public License Version 3 (19 November 2007). Please review LICENSE before you use or modify any of the code.

More permissive licensing may be available on request.

#### Getting Started
This is just a basic introduction on how to run the server yourself. There wont be too much detail as it is expected you understand the basics.
#### Prerequisites
> **Vagrant** (https://www.vagrantup.com/)

> **Virtual Box** (https://www.virtualbox.org/).

#### Installing
> **Clone the Repository** *(git clone https://github.com/mhaddon/Sound.je.Vagrant.git)*

> **Navigate to Directory**

> **Create Server**
> ```
>./create.sh

> While creating the server it will download A LOT of stuff, several key things are: Downloading a centos 7 box, downloading a ton of NPM modules, downloading a ton of maven modules, downloading a ton of server updates, installing several server packages... etc.
> Having good internet is heavily recommended.
>
> If your internet is not good enough, at several points you may recieve a message saying that the installation has failed, and the reason will be that it timedout.
>
> You can resume the process from where it left off after it fails, by running the command:
> ```
> vagrant provision

> **Add Website to Your Host Machines hosts File**
> Add "127.0.0.1  sound.dev www.sound.dev api.sound.dev" to your hosts
>
> ```
> sudo -- sh -c "echo '127.0.0.1  sound.dev www.sound.dev api.sound.dev' >> /etc/hosts"

> **Connect to Server** - http://www.sound.dev:18080/
>
> The first connection will take a while, and it may take a few minutes for the server to come online.

> **Rebuild Server**
> ```
> vagrant provision

#### Contributing
Changes to this project would be appreciated, especially if anyone finds bugs or knows of better ways of solving problems.

#### File Structure:

```
  ├── manifests/                                puppet manifests
  └── modules/                                  puppet modules
```
#### License
```
   NestedBird  Copyright (C) 2016-2017  Michael Haddon

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License version 3
   as published by the Free Software Foundation.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
More permissive licensing may be available on request.