default[:elasticsearch][:cluster_name] = 'MyCluster'

if !node.roles.include?('dev') && node[:network][:ipaddress_eth0]
  default[:elasticsearch][:listen_address] = node[:network][:ipaddress_eth0]
else
  default[:elasticsearch][:listen_address] = '0.0.0.0'
end

default[:elasticsearch][:http_port] = 9200
default[:elasticsearch][:transport_port] = 9300

default[:elasticsearch][:shards] = 5
default[:elasticsearch][:replicas] = 1
default[:elasticsearch][:refresh_interval] = '1s'
default[:elasticsearch][:cache_field_type] = 'resident'
default[:elasticsearch][:seed_nodes] = []

default[:elasticsearch][:es_min_mem] = '512m'
default[:elasticsearch][:es_max_mem] = '1g'
default[:elasticsearch][:plugins] = []

default[:elasticsearch][:uid] = 806
default[:elasticsearch][:gid] = 806
