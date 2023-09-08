# a manifest that kills a process named killmenow

exec {'kill_killmenow':
    command => 'pkill killmenow',
    onlyif  => 'pgrep killmenow',
    path    => '/usr/bin:/bin',
}
