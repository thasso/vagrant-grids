Grid Engine VMS
===============
This repository contains a set of `Vagrant <http://www.vagrantup.com/>`_
configurations to boot single instance grid or HPC machines. This repository is
used as a test base for the `pyjip <http://github.com/thasso/pyjip>`_ pipeline
project where we needed a way to test the system in various grid environments.
Currently this repository contains setups for:

    * PBS/Torque
    * SGE
    * Openlava

Setup
-----
All machines can be found in their sub-folders within this repository. In each
folder you will find a ``Vagrantfile`` that contains the vagrant configuration.
In addition, the provisioning of the boxes is done with `salt
<http://www.saltstack.com/>`_.

If you run **vagrant < 1.3**, you will need to install the salty-vagrant
plugin for this to work::

    $> vagrant plugin install vagrant-salt

You can boot up one of the machines, for example::

    $> cd pbs
    $> vagrant up

