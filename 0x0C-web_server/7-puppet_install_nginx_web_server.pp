# Configure an Nginx server. Also make some redirects

package { 'installNginx':
  ensure => 'installed',
  name   => 'nginx',
}

file { 'setRootPage':
  ensure  => 'present',
  path    => '/var/www/html/index.nginx-debian.html',
  content => 'Hello World!',
}

file_line { 'redirectionSetup':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  after  => 'listen 80 default_server;',
}

service { 'startNginx':
  ensure  => 'running',
  name    => 'nginx',
  require => Package['nginx'],
}
