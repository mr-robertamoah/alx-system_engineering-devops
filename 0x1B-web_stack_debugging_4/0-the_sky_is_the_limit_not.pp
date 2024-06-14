# Increases the amount of traffic an Nginx server can handle.

# Increase the ULIMIT of the default file
exec { 'ulimit-increase-for-nginx':
  command => 'sed -i \'s/^ULIMIT=.*/ULIMIT="-n 8192"/\' /etc/default/nginx',
  path    => '/usr/local/bin/:/bin/'
} ->

# Running command to restart nginx
exec { 'restart-nginx':
  command => 'nginx restart',
  path    => '/etc/init.d/'
}
