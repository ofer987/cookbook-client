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

client_node = search(:node, 'role:client')[0]
restbus_node = search(:node, 'role:restbus')[0]

execute 'client node ip address' do
  action :run
  live_stream true
  command <<-COMMAND
    echo #{client_node};
    echo #{client_node.class};
    echo #{client_node['ipaddress']};
  COMMAND
end

client_server_names = [
  'localhost',
  node['ipaddress'],
  node['transit.tips']['client']['domain'],
  node['transit.tips']['load_balancer']['domain']
]

restbus_server_names = [
  node['transit.tips']['restbus']['domain']
]

nginx_site 'load_balancer' do
  action :enable
  name 'load_balancer'
  template 'load_balancer.erb'
  variables(
    # client
    client_ip_address: client_node['ipaddress'],
    client_server_names: client_server_names.join(' '),
    client_domain: node['transit.tips']['client']['domain'],
    client_public_url: node['transit.tips']['client']['public_url'],

    # restbus
    restbus_ip_address: restbus_node['ipaddress'],
    restbus_server_names: restbus_server_names.join(' '),
    restbus_domain: node['transit.tips']['restbus']['domain'],
    restbus_public_url: node['transit.tips']['restbus']['public_url'],

    # ssl
    ssl_certificate_path: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end
