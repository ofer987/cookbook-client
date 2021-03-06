#
# Cookbook:: transit.tips
# Recipe:: ttc_notices
#
# The MIT License (MIT)
#
# Copyright:: 2017, Dan Jakob Ofer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# require 'pry-byebug'
#
# results = search("role:client*")
# puts results
#
# File.write("#{ENV['HOME']}/simple.txt", "hello")
# File.write("#{ENV['HOME']}/details.txt", Chef::Config)
# File.write("#{ENV['HOME']}/ancestors.txt", Chef::Config.ancestors)

apt_update 'daily' do
  frequency 86_400
  action :periodic
end

include_recipe 'transit.tips::users'
include_recipe 'transit.tips::global_settings'
include_recipe 'transit.tips::git'
include_recipe 'transit.tips::ruby'
include_recipe 'transit.tips::install_postgresql_client'
include_recipe 'transit.tips::ttc_notices_install'
include_recipe 'transit.tips::start_cron_jobs'
