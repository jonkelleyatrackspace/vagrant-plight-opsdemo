# vagrant-opscon-plight-demo
Simple scripts to use vagrant to test out a plight install.

## Overview

Develop your puppet modules & features like a human being!  No puppet master required.  Cut the strings!


## Prerequisite

* Install vagrant: http://www.vagrantup.com/downloads.html (I already had vagrant on my machine so I couldn't tell you the specifics)
* Install ruby?  - I have ruby 2.1
* Clone this repo

## Setting up your dev environment

* `config.yml` - enumerate the VM nodes you want to run & their IPs.
* `manifests/site.pp` - emumerate which puppet profiles to on which VM nodes.
* `modules` - Copy your puppet modules into this directory.  E.g., `modules/your_puppet_module/...`

## Running vagrant & testing puppet

From vargrant-puppet-dev-env run the following commands:
* `vagrant init` - Run once to initialize your vagrant environment
* `vagrant up [node]` - Bring up a VM & provision with puppet
* `vagrant provision [node]` - Provision an existing running VM with puppet (helpful on iterating)
* `vagrant ssh [node]` - `ssh` into a running VM
* `vagrant halt [node]` - Shutdown the VM

## More info
For Rackers, also check out:https://one.rackspace.com/pages/viewpage.action?title=How+to+test+puppet+changes+locally+using+vagrant&spaceKey=cloudfeeds
