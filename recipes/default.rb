#
# Cookbook Name:: simple_slack_handler
# Recipe:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.
handler_path = node['chef_handler']['handler_path']

cookbook_file "#{handler_path}/simple_slack_handler.rb" do
  source 'simple_slack_handler.rb'
  mode '0600'
  action :nothing
end.run_action(:create)

chef_handler 'Chef::Handler::SimpleSlackHandler' do
  source "#{node['chef_handler']['handler_path']}/simple_slack_handler.rb"
  arguments [
    node['handler']['slack']
  ]
  supports start: false, report: false, exception: true
  action :nothing
end.run_action(:enable)
