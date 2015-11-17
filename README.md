# vagrant-plight-opsdemo
Simple scripts to use vagrant to test out a plight install.

## Overview

This will install a loadbalancer listening at http://10.10.10.11:5000
```vagrant ssh nginx-n01.localdomain```
or
```vagrant ssh nginx-n02.locald.omain```

and ```sudo plight disable``` to demonstrate health monitoring to pull nodes out of rotation. This can be done with F5's as well.

## Prerequisite

* Install vagrant: http://www.vagrantup.com/downloads.html (I already had vagrant on my machine so I couldn't tell you the specifics)
* Install ruby?  - I have ruby 2.1
* Clone this repo

## Running vagrant & testing puppet

From this cloned folder run the following commands:
* `vagrant init` - Run once to initialize your vagrant environment
* `vagrant up [node]` - Bring up a VM & provision with puppet
* `vagrant provision [node]` - Provision an existing running VM with puppet (helpful on iterating)
* `vagrant ssh [node]` - `ssh` into a running VM
* `vagrant halt [node]` - Shutdown the VM

