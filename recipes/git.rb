#
# Cookbook:: transit.tips
# Recipe:: git
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'git::default'

chef_user = my_chef_user

execute 'start ssh agent' do
  action :run
  user chef_user.name
  command 'eval `ssh-agent`'
end

rsa_ofer987_key_path = File.join(
  Chef::Config[:file_cache_path],
  'rsa_github_ofer987'
)
cookbook_file rsa_ofer987_key_path do
  action :create
  owner chef_user.name
  mode '0400'
  source 'rsa_github_ofer987'
end

ssh = File.join(chef_user.home, '.ssh')
directory ssh do
  owner chef_user.name
  action :create
end

known_hosts = File.join(ssh, 'known_hosts')
file known_hosts do
  owner chef_user.name
  action :create
end

# add github.com as a known host
execute "add github.com to #{known_hosts}" do
  action :run
  user chef_user.name
  command "echo `ssh-keyscan github.com` >> #{known_hosts}"
end

# transit.tips
if Dir.exist?(chef_user.transit_tips_path)
  FileUtils.rm_r(chef_user.transit_tips_path)
end
execute 'clone transit.tips' do
  action :run
  user chef_user.name
  command <<-COMMAND
  git clone #{node['transit.tips']['url']} #{chef_user.transit_tips_path}
  COMMAND
end

# Secrets
FileUtils.rm_r(chef_user.secrets_path) if Dir.exist?(chef_user.secrets_path)
execute 'clone secrets' do
  action :run
  user chef_user.name
  command <<-COMMAND
    eval `ssh-agent`;
    ssh-add #{rsa_ofer987_key_path};
    git clone #{node['secrets']['url']} #{chef_user.secrets_path}
  COMMAND
end

file rsa_ofer987_key_path do
  action :delete
end
