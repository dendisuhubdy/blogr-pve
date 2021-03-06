class pve::profiles::common {
  Apt::Ppa <| |> -> Package <| |>
  Apt::Key<| |> -> Package<| |>

  include sudo

  # include unattended_upgrades
  # trouble to get this working on debian9

  #  class { 'apt':
  #    update => {
  #      frequency => 'daily',
  #    },
  #  }


  class { 'timezone':
    timezone => 'Europe/Oslo',
  }

  class { 'ssh::server':
    storeconfigs_enabled => false,
    options              => {
      'PermitRootLogin'                 => 'no',
      'ChallengeResponseAuthentication' => 'no',
      'PasswordAuthentication'          => 'no',
    },
  }

  class { 'locales':
    default_locale => 'nb_NO.UTF-8',
    locales        => ['en_US.UTF-8 UTF-8', 'nb_NO.UTF-8 UTF-8'],
  }

  file { "/opt/puppet/pve/apply.sh":
    mode => "744",
  }

  file { "/opt/puppet/pve":
    ensure => directory,
  }

  exec { "chown pve":
    require => [File['/opt/puppet/pve'], User['jenkins']],
    command => "/bin/chown -R jenkins.jenkins /opt/puppet/pve",
  }

}
