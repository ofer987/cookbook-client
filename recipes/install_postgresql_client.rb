#
# Cookbook:: transit.tips
# Recipe:: install_postgresql_client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: rename to web_client or something else or put in a module/dir

chef_user = my_chef_user

execute 'install PostgreSQL development pacakge' do
  command 'apt-get install -y libpq-dev'
  user 'root'
end
