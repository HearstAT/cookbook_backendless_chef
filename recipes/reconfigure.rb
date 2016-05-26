#
# Cookbook Name:: backendless_chef
# Recipe:: reconfigure
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

execute 'chef-server-ctl reconfigure'

execute 'chef-server-ctl restart' do
  action :run
  retries 3
  retry_delay 60
end

execute 'opscode-reporting-ctl reconfigure --accept-license'
execute 'chef-manage-ctl reconfigure --accept-license'

execute 'core-bundle' do
  command "tar -czvf #{node['backendless_chef']['s3']['dir']}/core_bundle.tar.gz /etc/opscode"
  action :run
  only_if { node['backendless_chef']['master'] == node['fqdn'] }
end

execute 'reporting-bundle' do
  command "tar -czvf #{node['backendless_chef']['s3']['dir']}/reporting_bundle.tar.gz /etc/opscode-reporting"
  action :run
  only_if { node['backendless_chef']['master'] == node['fqdn'] }
end
