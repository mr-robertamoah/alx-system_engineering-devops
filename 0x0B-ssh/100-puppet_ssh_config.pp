file {'config':
    ensure  => 'present',
    path    => '/etc/ssh/ssh_config',
    content => '\n  PasswordAuthentication no\n  IdentityFile ~/.ssh/school'
}
