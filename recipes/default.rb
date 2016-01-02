#
# Cookbook Name:: chef_website_example
# Recipe:: default
#
# Copyright (c) 2016 Kevin Runde, All Rights Reserved.

#Create intial user and group for WWW files
group node['www_files']['group']

user node['www_files']['user'] do
  group node['www_files']['group']
  system true
  shell '/bin/bash'
end

# Install Apache and start the service
httpd_service 'default' do
  action [:create, :start]
end

# Add the site configuration
httpd_config 'default' do
  instance 'default'
  source 'httpd.conf.erb'
  notifies :restart, 'httpd_service[default]'
end

# Create the document root
directory node['www_files']['document_root'] do
  recursive true
end

# Write the home page
template "#{node['www_files']['document_root']}/index.html" do
  source 'index.html.erb'
  mode '0644'
  owner node['www_files']['user']
  group node['www_files']['group']
end
