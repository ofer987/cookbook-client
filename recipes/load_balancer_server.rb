include_recipe 'nginx::default'

chef_user = my_root_user

ssl_certificate_path = File.join(
  chef_user.secrets_path,
  'certificates',
  'transit.tips.chained.crt'
)
ssl_key_path = File.join(
  chef_user.secrets_path,
  'certificates',
  'transit.tips.key'
)

# client_node = search(:node, 'role:client')[0]
# restbus_node = search(:node, 'role:restbus')[0]

client_nodes = get_nodes('restbus')
restbus_node = get_nodes('restbus').first
ttc_notices_node = get_nodes('restbus').first

# execute 'client node ip address' do
#   action :run
#   live_stream true
#   command <<-COMMAND
#     echo #{client_node};
#     echo #{client_node.class};
#     echo #{client_node['ipaddress']};
#   COMMAND
# end

client_server_names = [
  'localhost',
  node['ipaddress'],
  node['transit.tips']['client']['domain'],
  node['transit.tips']['load_balancer']['domain']
]

restbus_server_names = [
  node['transit.tips']['restbus']['domain']
]

ttc_notices_server_names = [
  node['transit.tips']['ttc_notices']['domain']
]

nginx_site 'load_balancer' do
  action :enable
  name 'load_balancer'
  template 'load_balancer.erb'
  variables(
    domain: node['transit.tips']['domain'],

    # client
    client_nodes: client_nodes,
    client_server_names: client_server_names.join(' '),

    # restbus
    restbus_node: restbus_node,
    restbus_server_names: restbus_server_names.join(' '),

    # restbus
    ttc_notices_node: ttc_notices_node,
    ttc_notices_server_names: ttc_notices_server_names.join(' '),

    # ssl
    ssl_certificate_path: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end
