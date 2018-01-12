#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2011, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'java'

# If we write to :seed_nodes it will never search for that node again
# We want it to always search unless we've set :seed_nodes in the
# role or environment
# For Chef-Solo we can set seed_nodes to nil safely
seed_nodes = node['elasticsearch']['seed_nodes'] || []
if seed_nodes && seed_nodes.empty?
  Chef::Log.debug("\e[32mElasticsearch:\e[33m computing seed_nodes.\e[0m")
  search(:node, "(recipes:elasticsearch OR recipes:elasticsearch\\:\\:default) AND chef_environment:#{node.chef_environment}") do |n|
    if n['elasticsearch']['cluster_name'] == node['elasticsearch']['cluster_name']
      # |= only add node if doesn't already exist, just a failsafe
      seed_nodes |= [n.ipaddress]
    end
    seed_nodes.sort!
  end
end

Chef::Log.debug("\e[32mElasticsearch:\e[33m computed seed_nodes: #{seed_nodes}.\e[0m")

# Add intapt repository that has an `elasticsearch` package. Upstream does not provide one
include_recipe 'ele-apt'

package 'elasticsearch' do
  version '5.6.5'
end

directory '/etc/elasticsearch' do
  owner 'root'
  group 'root'
  mode 0o755
end

group 'elasticsearch' do
  gid node['elasticsearch']['gid']
end

user 'elasticsearch' do
  comment 'elasticsearch daemon user'
  gid node['elasticsearch']['gid']
  uid node['elasticsearch']['uid']
  system true
  shell '/bin/false'
end

directory '/var/lib/elasticsearch' do
  owner 'elasticsearch'
  group 'elasticsearch'
  mode 0o700
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  mode 0o0644
  variables(
    seed_nodes: seed_nodes,
    client_only: false
  )
  notifies :restart, 'service[elasticsearch]', :delayed
end

template '/etc/elasticsearch/logging.yml' do
  source 'logging.yml.erb'
  mode 0o0644
  notifies :restart, 'service[elasticsearch]', :delayed
end

runit_service 'elasticsearch' do
  owner 'daemon'
  group 'daemon'
  sv_timeout 180
end

iptables_rule 'ports_elasticsearch' do
  variables(
    seed_nodes: seed_nodes
  )
end
