#
# Cookbook:: transit.tips
# Recipe:: restbus_server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'nginx::default'

chef_user = my_chef_user

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

server_names = [
  'localhost',
  node['ipaddress'],
  node['transit.tips']['restbus']['domain']
]

execute 'which erb live stream' do
  action :run
  user chef_user.name
  live_stream true
  command 'echo `which erb`'
end

rbenv_script 'install restbus' do
  rbenv_version '2.4.1'
  user chef_user.name
  cwd chef_user.restbus_path
  code <<-COMMAND
    make install
  COMMAND
end

template '/etc/systemd/system/puma.service' do
  source 'puma.service.erb'
  mode '0644'

  variables(
    user: chef_user.name,
    wd: chef_user.restbus_path,
    path: "#{chef_user.home}/.rbenv/shims/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games",
    command: File.join(chef_user.home, '.rbenv', 'shims', 'bundle'),
    arguments: 'exec puma -C ' +
      File.join(chef_user.restbus_path, 'config', 'puma.rb')
  )
end

# Start Puma process
service 'start puma app server as background process' do
  action :start

  start_command <<-COMMAND
    service puma start;
  COMMAND
end

nginx_site 'restbus' do
  action :enable
  name 'restbus'
  template 'restbus.erb'
  variables(
    restbus_path: File.join(chef_user.restbus_path),
    server_names: server_names.join(' '),
    ssl_certificate_path: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end
