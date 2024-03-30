# Setup Nginx server with some custom header response
package { 'nginx':
  ensure => installed,
}

file_line { 'b':
  ensure  => present,
  path    => '/etc/nginx/sites-available/default',
  after   => 'listen 80 default_server;',
  line    => 'add_header X-Served-By $HOSTNAME;',
  require => Package['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  require   => Package['nginx'],
}
