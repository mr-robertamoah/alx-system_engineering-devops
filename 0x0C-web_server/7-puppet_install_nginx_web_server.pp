# installs and configures nginx

exec {'update':
    command => 'sudo apt-get update -y && sudo apt-get upgrade -y',
    path    => ['/usr/bin']
}

package {'nginx':
    ensure => 'installed',
}

file {'index':
    ensure  => 'present',
    path    => '/var/www/html/index.html',
    content => "Hello World!\n"
}

file {'404':
    ensure  => 'present',
    path    => '/var/www/html/404.html',
    content => "Ceci n\'est pas une page\n\n"
}

file {'default':
    ensure  => 'present',
    path    => '/etc/nginx/sites-enabled/default',
    content => '
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;

        location / {
                try_files /index.html =404;
        }

	error_page 404 /404.html;
	location / {
        	return 404;
	}
	location = /404.html {
        	root /var/www/html;
	        internal;
	}
}',
    notify  => Service['nginx']
}

service {'nginx':
    ensure  => 'running',
    enable  => 'true',
    require => File['default']
}
