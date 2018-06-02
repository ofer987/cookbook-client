#
# Cookbook:: transit.tips
# Recipe:: ruby
#
# Copyright:: 2017, The Authors, All Rights Reserved.

chef_user = my_chef_user
ruby_version = '2.4.1'

rbenv_user_install chef_user.name
rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user chef_user.name
end
rbenv_ruby ruby_version do
  user chef_user.name
end
rbenv_global ruby_version do
  user chef_user.name
end
rbenv_gem 'bundler' do
  version '1.16.2'
  user chef_user.name
  rbenv_version ruby_version
  options '--no-document'
end
