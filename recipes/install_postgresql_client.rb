#
# Cookbook:: transit.tips
# Recipe:: install_postgresql_client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: rename to web_client or something else or put in a module/dir

chef_user = my_chef_user

postgresql_client_install do
  version '9.6'
  port 5432
end
