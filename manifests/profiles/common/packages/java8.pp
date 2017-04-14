class pve::profiles::common::packages::java8 {
  apt::source { 'webupd8team':
    location => 'http://ppa.launchpad.net/webupd8team/java/ubuntu',
    repos    => 'main',
    key      => {
      'id'     => 'EEA14886',
      'server' => 'keyserver.ubuntu.com',
    },
    notify   => Exec["apt_update"]
  }

  exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';

    'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
  }

  package { 'oracle-java8-installer':
    ensure  => 'installed',
    require => [Apt::Source['webupd8team'], Exec['set-licence-selected'], Exec['set-licence-seen']],
  } ->
  package { 'oracle-java8-set-default':
    ensure => 'installed',
  }
}