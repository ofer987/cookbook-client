#
# Cookbook:: transit.tips
# Recipe:: restbus_server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

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
  command 'echo `whoami`'
end

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

rbenv_script 'info rbenv' do
  rbenv_version '2.4.1'
  user chef_user.name
  # cwd chef_user.restbus_path
  code <<-COMMAND
    echo ' ' >> #{File.join(chef_user.home, 'path.txt')};
    echo $PATH >> #{File.join(chef_user.home, 'path.txt')};
    echo `pwd` >> #{File.join(chef_user.home, 'path.txt')};
    echo `whoami` >> #{File.join(chef_user.home, 'path.txt')};
    echo `which bundle` >> #{File.join(chef_user.home, 'path.txt')};
    echo ' ' >> #{File.join(chef_user.home, 'path.txt')};
  COMMAND
end

rbenv_script 'install restbus' do
  rbenv_version '2.4.1'
  user chef_user.name
  cwd chef_user.restbus_path
  code <<-COMMAND
    make install
  COMMAND
end

# execute "copy transit.tips to #{nginx_user.name}'s home directory" do
#   action :run
#
#   # Maybe this should be mv?
#   command <<-COMMAND
#     cp -R #{chef_user.transit_tips_path} #{nginx_user.transit_tips_path};
#   COMMAND
# end
#
# execute "change owner of transit.tips to #{nginx_user.name}" do
#   action :run
#
#   command <<-COMMAND
#     chown -R #{nginx_user.name} #{nginx_user.transit_tips_path};
#   COMMAND
# end

template '/etc/systemd/system/puma.service' do
  source 'puma.service.erb'
  mode '0644'

  variables(
    wd: chef_user.restbus_path,
    path: "#{chef_user.home}/.rbenv/shims/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games",
    command: File.join(chef_user.home, '.rbenv', 'shims', 'bundle'),
    arguments: 'puma -C ' +
      File.join(chef_user.restbus_path, 'config', 'puma.rb')
  )
end

# # Start Puma process
# service 'start puma app server as background process' do
#   action :start
#   user chef_user.name
#
#   start_command <<-COMMAND
#     cd #{chef_user.restbus_path};
#     bin/puma -C config/puma.rb;
#   COMMAND
# end
#
# nginx_site 'restbus' do
#   action :enable
#   name 'restbus'
#   template 'restbus.erb'
#   variables(
#     restbus_path: File.join(nginx_user.restbus_path),
#     server_names: server_names.join(' '),
#     ssl_certificate_path: ssl_certificate_path,
#     ssl_certificate_key: ssl_key_path
#   )
# end

# restart nginx service
# execute 'restart nginx server' do
#   action :run
#
#   command <<-COMMAND
#     service nginx restart;
#   COMMAND
# end
