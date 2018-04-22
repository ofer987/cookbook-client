#
# Cookbook:: transit.tips
# Recipe:: ruby
#
# Copyright:: 2017, The Authors, All Rights Reserved.

rbenv_system_install 'default' do
  update_rbenv false
end

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
end

rbenv_ruby '2.4.1' do
end

rbenv_global '2.4.1' do
end

rbenv_gem 'bundler' do
  rbenv_version '2.4.1'
end

rbenv_rehash 'default' do
end
