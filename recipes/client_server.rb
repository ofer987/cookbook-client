#
# Cookbook:: transit.tips
# Recipe:: client_server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: rename to web_client or something else or put in a module/dir

include_recipe 'nginx::default'

chef_user = my_chef_user
nginx_user = my_nginx_user

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

execute 'who am i' do
  action :run
  live_stream true
  command 'whoami'
end

server_names = [
  'localhost',
  node['ipaddress'],
  node['transit.tips']['client']['domain']
]

rbenv_script 'install client' do
  rbenv_version '2.4.1'
  user chef_user.name
  cwd chef_user.client_path
  code <<-COMMAND
    RESTBUS_URL=#{node['transit.tips']['restbus']['public_url']} \
    make install
  COMMAND
end

nginx_site 'client' do
  action :enable
  name 'client'
  template 'client.erb'
  variables(
    path: chef_user.client_path,
    server_names: server_names.join(' '),
    ssl_certificate_path: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end

# execute 'which erb live stream' do
#   action :run
#   user chef_user.name
#   live_stream true
#   command 'echo `which erb`'
# end

# execute "copy transit.tips to nginx's www directory" do
#   action :run
#
#   # Maybe this should be mv?
#   command "cp -R #{chef_user.transit_tips_path} #{nginx_user.transit_tips_path}"
# end
