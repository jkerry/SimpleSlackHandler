default['handler']['slack']['channel'] = '#channel'
default['handler']['slack']['token'] = 'SLACK_API_KEY'
default['handler']['slack']['username'] = 'Simple Slack Handler'
default['handler']['slack']['icon_emoji'] = ':rotating_light:'
default['handler']['slack']['handler_path'] = "#{File.expand_path(File.join(Chef::Config[:file_cache_path], '..'))}/handlers"
