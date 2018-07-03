#
# Cookbook:: transit.tips
# Recipe:: nodejs
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'nodejs'
include_recipe 'nodejs::npm'

npm_package 'elm' do
  version '0.18.0'
end

npm_package 'elm-css' do
  version '0.6.1'
end
