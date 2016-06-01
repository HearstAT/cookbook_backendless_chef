#
# Cookbook Name:: backendless_chef
# Recipe:: default
#
# Copyright 2016, Hearst Automation Team
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

node.default['backendless_chef']['database']['username'] = citadel['db/username']
node.default['backendless_chef']['database']['password'] = citadel['db/password']

package 'chef-server-core'

# Make sure /etc/opscode exists
directory '/etc/opscode' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

# Render the chef-server.rb config file
template '/etc/opscode/chef-server.rb' do
  action :create
  source 'chef_server.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Make sure /etc/opscode exists
#directory '/etc/opscode-reporting' do
#  action :create
#  owner 'root'
#  group 'root'
#  mode '0755'
#end

#template '/etc/opscode-reporting/opscode-reporting.rb' do
#  action :create
#  source 'opscode_reporting.erb'
#  owner 'root'
#  group 'root'
#  mode '0644'
#end

include_recipe 'backendless_chef::disable_iptables'
include_recipe 'backendless_chef::mail'
include_recipe 'backendless_chef::bootstrap'
include_recipe 'backendless_chef::manage'
include_recipe 'backendless_chef::stage'
#include_recipe 'backendless_chef::reporting'
include_recipe 'backendless_chef::backup'
include_recipe 'backendless_chef::sync'
include_recipe 'backendless_chef::reconfigure'

if node['backendless_chef']['newrelic']['enable']
  include_recipe 'backendless_chef::newrelic'
end
if node['backendless_chef']['sumologic']['enable']
  include_recipe 'backendless_chef::sumologic'
end

execute 'chef-server-ctl restart' do
  action :run
  retries 3
  retry_delay 60
end

execute 'chef-manage-restart' do
  command 'chef-manage-ctl restart'
end
