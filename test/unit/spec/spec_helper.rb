# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'
# require 'coveralls'

# Coveralls.wear!

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '14.04',
  log_level: ::LOG_LEVEL
}.freeze
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}.freeze

def stub_resources
  stub_search("node", "(recipes:elasticsearch OR recipes:elasticsearch\\:\\:default) AND chef_environment:_default").and_return(true)
end

at_exit { ChefSpec::Coverage.report! }
