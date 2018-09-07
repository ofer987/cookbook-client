#
# Cookbook:: transit.tips
# Recipe:: ttc_notices_install
#
# Copyright:: 2017, The Authors, All Rights Reserved.

chef_user = my_chef_user

rbenv_script 'install ttc_notices' do
  rbenv_version '2.4.1'
  user chef_user.name
  cwd chef_user.ttc_notices_path
  code <<-COMMAND
    make install
  COMMAND
end

# rbenv_gem 'install clockwork' do
#   user chef_user.name
#   rbenv_version ruby_version
#   options '--no-document'
# end
