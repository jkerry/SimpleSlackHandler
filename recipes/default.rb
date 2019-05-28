#
# Cookbook Name:: simple_slack_handler
# Recipe:: default
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.

handler_path = node['handler']['slack']['handler_path']

directory handler_path do
  recursive true
  action :nothing
end.run_action(:create)

cookbook_file "#{handler_path}/simple_slack_handler.rb" do
  source 'simple_slack_handler.rb'
  mode '0600'
  action :nothing
end.run_action(:create)

# register the new handler. This is done at runtime to avoid an unnecessary
# converge count so this remains idempotent. This can be removed when the
# chef_handler resource is idempotent
require "#{handler_path}/simple_slack_handler.rb"

# pull in the utility functions from this cookbook
Chef::Recipe.send(:include, ::SimpleSlackHandler::Helpers)

# generate handler
handler = Chef::Handler::SimpleSlackHandler.new(*collect_args([node['handler']['slack']]))

# unregister the handler aggressively in case it's loaded
Chef::Config.exception_handlers.delete_if { |v| v.class.name == handler.class.name }

# register the module for exceptions
Chef::Config.exception_handlers << handler
