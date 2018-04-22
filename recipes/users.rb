#
# Cookbook:: transit.tips
# Recipe:: users
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory my_nginx_user.home do
  recursive true
  mode 0755
  owner 'root'
  group 'root'

  action :create
end
