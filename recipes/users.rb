#
# Cookbook:: transit.tips
# Recipe:: users
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory my_nginx_user.home do
  recursive true
  mode '0755'
  owner 'root'
  group 'root'

  action :create
end

chef_user = my_chef_user
user my_chef_user.name do
  action :create
  password '$1$SNHhix3P$Sm9GTn.JKoiWSGQmWR9M2/'
  comment 'run make install on transit.tips project'
  shell '/bin/bash'
  home chef_user.home
  manage_home true
end
