class pve::roles::host{
  include pve::profiles::common
  include pve::profiles::common::packages
  include pve::profiles::common::users
  include pve::profiles::network
  include pve::profiles::logging::forwarder
  include pve::profiles::config::agent
  include pve::profiles::rancher::host
  include pve::profiles::monitoring::agent

}