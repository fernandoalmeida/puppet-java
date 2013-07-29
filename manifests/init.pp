# == Class: java
#
# A Puppet module for installing and configuring Java.
#
# === Examples
#
#  include java
#
# === Authors
#
# Fernando Almeida <fernando@fernandoalmeida.net>
# 
# === Copyright
# 
# Copyright 2013 Fernando Almeida, unless otherwise noted.
#
class java {
  
  exec {"java-ppa":
    command => "add-apt-repository ppa:webupd8team/java",
    unless  => "apt-key list | grep EEA14886",
  }->
  exec {"accept_oracle_license":
    command => "echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections",
    unless  => "debconf-get-selections | grep accepted-oracle-license-v1-1 | grep select | grep true",
  }->
  exec {'java-apt-get-update':
    command     => "apt-get update",
  }->
  package {["oracle-java7-installer", "oracle-java7-set-default"]:
    ensure  => installed,
  }
  
}
