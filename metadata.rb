name 'elasticsearch'
maintainer 'Rackspace'
maintainer_email 'sfo-devops@lists.rackspace.com'
license 'Apache-2.0'
description 'Installs/Configures elasticsearch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.6'
issues_url 'https://github.com/mmi-cookbooks/elasticsearch-chef/issues'
source_url 'https://github.com/mmi-cookbooks/elasticsearch-chef'
chef_version '>= 12' if respond_to?(:chef_version)

depends 'ele-apt'
depends 'iptables'
depends 'java'
depends 'ohai'
depends 'runit'

supports 'debian'
supports 'ubuntu'