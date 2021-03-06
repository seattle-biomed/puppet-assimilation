# == Class: assimilation::package
#
# Full description of class assimilation is in the README.
#
class assimilation::package (
  $ensure         = $assimilation::package_ensure,
  $package_source = $assimilation::package_source,
  $package_name   = $assimilation::package_name,
) {
  exec { 'download_assimilation_package':
    command => "/usr/bin/wget ${package_source}/${package_name}.deb",
    cwd     => '/tmp',
    creates => "/tmp/${package_name}.deb",
  } ->
  exec { 'install_package':
    command => "/usr/bin/dpkg -i /tmp/${package_name}.deb",
    unless  => "/usr/bin/dpkg -l ${package_name}|/bin/grep -n 'ii'",
  }
}
