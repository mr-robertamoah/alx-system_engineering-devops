# installs and configures nginx

package {'nginx':
    ensure => 'present',
}


file {'index":
    ensure  => 'file',
    path    => '/var/www/html/index.html',
    content => 'Hello World!'
}

file {'404":
    ensure  => 'file',
    path    => '/var/www/html/404.html',
    content => 'Ceci n\'est pas une page\n'
}

file {'default":
    ensure  => 'file',
    path    => '/etc/nginx/sites-enabled/default',
    content => '
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location /redirect_me {
                return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }

        location / {
                try_files \$uri \$uri/ =404;
        }

        error_page 404 /404.html;
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
