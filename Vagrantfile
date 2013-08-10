# -*- mode: ruby -*-
# vi: set ft=ruby :

nodes = {
  'workstation' => {},
}
node_defaults = {
  :image  => 'Ubuntu 13.04 x64',
  :region => 'Amsterdam 1',
  :size   => '512MB',
}

Vagrant.configure('2') do |config|
  config.ssh.private_key_path = '~/.ssh/id_rsa'
  config.vm.box = 'dummy'
  config.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
  config.ssh.username = 'garethr'
  config.vm.provision :shell, :path => 'bootstrap.sh'
  config.vm.provision :shell, :path => 'librarian.sh'
  config.vm.provision :puppet do |puppet|
    puppet.options = '--debug --verbose --summarize --reports store --hiera_config /vagrant/hiera.yaml'
    puppet.facter = { 'fqdn' => 'workstation' }
    puppet.manifests_path = 'manifests'
    puppet.module_path    = [ 'modules', 'vendor/modules' ]
    puppet.manifest_file  = 'base.pp'
  end

  nodes.each do |node_name, node_opts|
    config.vm.define node_name do |node|
      node_opts = node_defaults.merge(node_opts)

      node.vm.hostname = node_name
      node.vm.provider :digital_ocean do |provider|
        provider.ca_path = '/etc/ssl/certs/ca-certificates.crt'
        provider.client_id = ENV['DIGITAL_OCEAN_CLIENT_ID']
        provider.api_key = ENV['DIGITAL_OCEAN_API_KEY']
        provider.image = node_opts[:image]
        provider.region = node_opts[:region]
        provider.size = node_opts[:size]
      end

    end
  end
end
