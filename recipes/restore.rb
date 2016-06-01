#
# Cookbook Name:: backendless_chef
# Recipe:: backup
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

execute 's3-backup-get' do
  command "cp -f #{node['backendless_chef']['s3']['dir']}/backup.tar #{Chef::Config[:file_cache_path]}/backup.tar"
  action :run
  only_if { node['backendless_chef']['backup']['restore'] }
end

execute 'backup-extract' do
  command "tar -xzf #{Chef::Config[:file_cache_path]}/backup.tar --strip-components=1"
  action :run
  cwd Chef::Config[:file_cache_path]
  only_if { node['backendless_chef']['backup']['restore'] }
end

execute 'knife-backup-restore-ext' do
  command "/opt/opscode/embedded/bin/knife ec restore #{Chef::Config[:file_cache_path]}/backup -s https://#{node['backendless_chef']['stage_subdomain']}.#{node['backendless_chef']['prime_domain']} --with-user-sql --skip-useracl --sql-host #{node['backendless_chef']['database']['url']}"
  action :run
  only_if { node['backendless_chef']['backup']['restore'] }
end

