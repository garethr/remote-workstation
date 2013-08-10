Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

hiera_include('classes')

ufw::allow { 'allow-ssh-from-all':
  port => 22,
}

sudo::conf { 'garethr':
  priority => 30,
  content  => 'garethr ALL=(ALL) NOPASSWD:ALL',
}
