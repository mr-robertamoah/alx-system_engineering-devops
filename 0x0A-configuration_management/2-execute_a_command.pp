# a manifest that kills a process named killmenow if its running

exec {'kill':
    command => 'pkill -f killmenow',
    onlyif  => 'pgrep killmenow',
    path    => '/usr/bin:/bin'
}
