# Simple Drupal Development VM

**For a fully-featured VM environment for Drupal, please check out [Drupal VM](https://www.drupalvm.com/).**

This project makes local Drupal test/development environment management quick and easy. It installs the following on an Ubuntu VM:

  - Apache
  - PHP
  - MySQL
  - Drush
  - Drupal

It takes 5-10 minutes to build or rebuild the VM from scratch on a decent broadband connection.

## Quick Start Guide

### 1 - Install dependencies (VirtualBox, Vagrant, Ansible)

  1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  2. Download and install [Vagrant](http://www.vagrantup.com/downloads.html).
  3. [Mac/Linux only] Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

Note for Windows users: *This guide assumes you're on a Mac or Linux host. Windows support may be added when I get a little more time; the main difference is Ansible needs to be bootstrapped from within the VM after it's created. See [JJG-Ansible-Windows](https://github.com/geerlingguy/JJG-Ansible-Windows) for more information.*

### 2 - Build the Virtual Machine

  1. Download this project and put it wherever you want.
  2. Open Terminal, cd to this directory (containing the `Vagrantfile` and this README file).
  3. Type in `vagrant up`, and let Vagrant do its magic.

Note: *If there are any errors during the course of running `vagrant up`, and it drops you back to your command prompt, just run `vagrant provision` to continue building the VM from where you left off. If there are still errors after doing this a few times, post an issue to this project's issue queue on GitHub with the error.*

### 3 - Configure your host machine to access the VM.

  1. [Edit your hosts file](http://docs.rackspace.com/support/how-to/modify-your-hosts-file/), adding the line `192.168.56.8  drupal.test` so you can connect to the VM.
  2. Open your browser and access [http://drupal.test/](http://drupal.test/).

## Notes

  - To shut down the virtual machine, enter `vagrant halt` in the Terminal in the same folder that has the `Vagrantfile`. To destroy it completely (if you want to save a little disk space, or want to rebuild it from scratch with `vagrant up` again), type in `vagrant destroy`.
  - You can change the version of Drupal installed by editing the variables within `vars.yml`.
  - Find out more about local development with Vagrant + VirtualBox + Ansible in this presentation: [Local Development Environments - Vagrant, VirtualBox and Ansible](http://www.slideshare.net/geerlingguy/local-development-on-virtual-machines-vagrant-virtualbox-and-ansible).
  - Learn about how Ansible can accelerate your ability to innovate and manage your infrastructure by reading [Ansible for DevOps](https://www.ansiblefordevops.com/).

## About the Author

This project was created by [Jeff Geerling](https://www.jeffgeerling.com/) as an example for [Ansible for DevOps](https://www.ansiblefordevops.com/).
