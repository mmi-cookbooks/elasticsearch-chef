name 'elasticsearch'
maintainer 'Rackspace'
maintainer_email 'sfo-devops@lists.rackspace.com'
license 'Apache 2.0'
description 'Installs/Configures elasticsearch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.6'

depends 'ele-apt'
depends 'iptables'
depends 'java'
depends 'ohai'
depends 'runit'
