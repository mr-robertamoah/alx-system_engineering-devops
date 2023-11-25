# a manifest that kills a process named killmenow

exec {'kill':
    command => 'pkill -f killmenow',
    onlyif  => 'pgrep killmenow',
    path    => '/usr/bin:/bin'
}
