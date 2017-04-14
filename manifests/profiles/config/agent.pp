class pve::profiles::config::agent {

  class { '::consul':
    init_style  => 'debian',
    config_hash => {
      'data_dir'   => '/opt/consul',
      'datacenter' => 'pve',
      'log_level'  => 'INFO',
      'node_name'  => "${::hostname}-agent",
      'retry_join' => ['10.0.50.106'],
    }
  }

  ::consul::check { 'check_disk_usage':
    script   => '/usr/lib/nagios/plugins/check_disk -w40% -c20% -p /',
    interval => '30s'
  }

  ::consul::check { 'check_cpuload':
    script   => '/usr/lib/nagios/plugins/check_load -r -w 0.7 -c 1',
    interval => '30s'
  }

  ::consul::check { 'check_swap':
    script   => '/usr/lib/nagios/plugins/check_swap -w 90 -c 50',
    interval => '30s'
  }

}