
# frozen_string_literal: true

# License:: Apache License, Version 2.0
#

require_relative 'spec_helper'

describe user('elasticsearch') do
  it { should exist }
  it { should belong_to_group 'elasticsearch' }
end

describe file('/var/lib/elasticsearch') do
  it { should be_directory }
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it { should be_file }
end

describe file('/etc/elasticsearch/logging.yml') do
  it { should be_file }
end

# runit
describe file('/etc/sv/elasticsearch/run') do
  it { should be_file }
end

# iptables
