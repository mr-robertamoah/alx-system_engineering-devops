file {'/etc/ssh/ssh_config':
    ensure  => 'present',
    content => "
    Host *
      IdentityFile ~/.ssh/school
      PasswordAuthentication no
      SendEnv LANG LC_*
      HashKnownHosts yes
      GSSAPIAuthentication yes
  "
}
