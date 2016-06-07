#
# Cookbook Name:: backendless_chef
# Recipe:: mail
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
# This recipe configures the postfix
#

package postfix
package sasl2-bin

service 'postfix' do
  action [:enable, :start]
end

template '/etc/postfix/main.cf' do
  source 'main.cf.erb'
  notifies :restart, 'service[postfix]'
end

file '/etc/postfix/sasl_passwd' do
  content citadel['mail/creds']
  owner 'root'
  group 'root'
  mode 00644
end

execute 'postmapcreds' do
  command 'postmap sasl_passwd'
  cwd '/etc/postfix'
  action :nothing
end
