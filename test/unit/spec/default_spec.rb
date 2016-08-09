require 'chefspec'
require_relative 'spec_helper'

describe 'elasticsearch::default' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: %w(iptables runit)) do |node|
      node.automatic['lsb']['codename'] = 'trusty'
    end.converge(described_recipe)
  end

#  it 'installs a package with an explicit action' do
#    expect(chef_run).to install_package('elasticsearch')
#  end
  it 'upgrades a package with an explicit action' do
    expect(chef_run).to upgrade_package('elasticsearch')
  end

  it 'creates a config template with an explicit action' do
    expect(chef_run).to create_template('/etc/elasticsearch/elasticsearch.yml')
  end

  it 'creates a logging template with an explicit action' do
    expect(chef_run).to create_template('/etc/elasticsearch/logging.yml')
  end
  
  it 'creates a directory /etc/elasticsearch' do
    expect(chef_run).to create_directory('/etc/elasticsearch')
  end
  it 'creates a directory /var/lib/elasticsearch' do
    expect(chef_run).to create_directory('/var/lib/elasticsearch')
  end
  it 'creates an elasticsearch user' do
    expect(chef_run).to create_user('elasticsearch')
  end
  it 'creates an elasticsearch group' do
    expect(chef_run).to create_group('elasticsearch')
  end
end
