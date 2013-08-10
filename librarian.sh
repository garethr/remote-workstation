#!/usr/bin/env bash
set -e

# These are outside modules and manifests and not rsynced into place
echo "Copy Puppetfile and librarian config into place"
cp /vagrant/Puppetfile /tmp/vagrant-puppet
cp -r /vagrant/.librarian /tmp/vagrant-puppet

cd /tmp/vagrant-puppet
echo "Install Puppet module dependencies"
librarian-puppet install

echo "Move vendored modules into place"
rm -fr /tmp/vagrant-puppet/modules-1/*
mv /tmp/vagrant-puppet/vendor/modules/* /tmp/vagrant-puppet/modules-1/
