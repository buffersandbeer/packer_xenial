# Ubuntu 16.04 Packer
This contains a packer build config that will set you up with a new 
ubuntu-server image that is configured and ready for use.

Why use this? Because it will let you build a brand new ubuntu image for your 
personal use. It is helpful when you want to create a new base image with new
credentials for challenges, when you want to update your regular vm base image, 
etc. It also means you can store a bunch of VM templates in a few KB of files
instead of having a lot of custom VM templates stored on your laptop or on 
Vcenter.

## Requirements:
* VMware (Fusion OR Workstation)
* [Packer](https://www.packer.io/downloads.html)

## Use:
* Clone repository
* Enter repository directory
* Modify `scripts/user.sh` to reflect passwords and ssh public keys you want set up in the system
* Run `packer build` on the build configuration
 * `packer build ubuntu.json`
* Finished VM image will be in `bin/`

## Debugging:
* You can turn off headless build mode so you can see the build happening
 * edit `ubuntu.json` and change `"headless": true` to `"headless": false`
* You can run packer in debug mode to walk through each step of the build one at a time
 * `packer build --debug ubuntu.json` 

## Build Specifics
* Root user will be set up with custom password / authorized_keys file
* Otto user will be set up with custom password / authorized_keys file
 * Otto is the user I use for ansible/vagrant automation. Not really mandatory
 * Otto will be set up with passwordless sudo access
* SSH will restrict root access to key based auth
* SSH server host-keys will be regenerated
* APT will be set up with proper repositories
* Beyond that, not much will be installed
* Iptables is set up for the default Firewall
 * Denys all incoming except SSH on port 22
 * Allows all outgoing