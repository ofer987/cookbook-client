#
# Cookbook:: transit.tips
# Recipe:: start_cron_jobs
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: rename to web_client or something else or put in a module/dir

chef_user = my_chef_user

rbenv_script 'start clockwork daemon' do
  rbenv_version '2.4.1'
  user chef_user.name
  cwd chef_user.ttc_notices_path
  code <<-COMMAND
    bin/clockworkd -c lib/clock.rb --log start
  COMMAND
end
