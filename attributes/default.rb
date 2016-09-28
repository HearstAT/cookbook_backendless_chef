#
# Cookbook Name:: backendless_chef
# Default Attributes File
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

# Pass to pull a backup and use knife ec to restore
default['backendless_chef']['backup']['enable_backups'] = false
default['backendless_chef']['backup']['restore_file'] = ''

# S3 Bucket mount location accomplished during CFN
default['backendless_chef']['s3']['dir'] = ''

# SSL Config
default['backendless_chef']['ssl']['enable'] = true

# Manage Attributes
default['backendless_chef']['manage']['signupdisable'] = ''
default['backendless_chef']['manage']['supportemail'] = ''

# Mail Relay host
default['backendless_chef']['mail']['relayhost'] = ''
default['backendless_chef']['mail']['relayport'] = ''

# License Count Info
default['backendless_chef']['licensecount'] = '25'

# FQDN of your Amazon Elastic Load Balancer or Route53 CNAME to load balancer DNS
default['backendless_chef']['api_fqdn'] = ''

# Domain provided via Route53 hosted zone
default['backendless_chef']['prime_domain'] = ''

# Database Config
default['backendless_chef']['database']['port'] = ''
default['backendless_chef']['database']['url'] = ''

# Database Config
default['backendless_chef']['search']['url'] = ''

# Citadel
default['citadel']['bucket'] = ''
default['sumologic']['userID'] = ''

# Newrelic
default['backendless_chef']['newrelic']['enable'] = true
default['backendless_chef']['newrelic']['appname'] = ''

# Sumologic
default['backendless_chef']['sumologic']['enable'] = true
