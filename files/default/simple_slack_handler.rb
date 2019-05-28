#
# Cookbook Name:: simple_slack_handler
#
# Copyright (c) 2016 John Kerry, All Rights Reserved.

require 'chef/handler'
require 'chef/resource/directory'
require 'date'

class Chef
  # Standard Chef Handler class
  class Handler
    # NCR Slack Handler
    class SimpleSlackHandler < ::Chef::Handler
      attr_reader :config, :attachment

      def initialize(config = {})
        initialize_config(config)
        initialize_attachment
      end

      def initialize_attachment
        @attachment = {
          fallback: 'Chef node has failed to converge!',
          color: '#CC0000',
          pretext: 'Chef node has failed to converge!',
          author_name: 'SimpleSlackHandler',
          title: 'Chef run failure report:',
          footer_icon: 'http://i.imgur.com/No1W49d.png',
          footer: 'Chef Status Report',
          ts: DateTime.now.strftime('%s')
        }
      end

      def initialize_config(config = {})
        @config = config
        @config['token'] ||= 'KEY'
        @config['channel'] ||= '#general'
        @config['username'] ||= 'Chef Simple Slack Handler'
        @config['icon_emoji'] ||= ':rotating_light:'
        @config
      end

      def report
        if exception
          Chef::Log.error('Creating slack exception report')
          slack_msg = build_run_failed_message
          post_to_slack(slack_msg)
        end
      end

      private

      def generate_exception_field
        [
          {
            title: 'Exception',
            value: exception.to_s,
            short: false
          }
        ]
      end

      def build_attachments_json
        attachment[:pretext] =
          "Chef node: #{node.name} ( fqdn:#{node['fqdn']} )"\
          ' has failed to converge!'
        attachment[:fallback] = exception.to_s
        attachment[:fields] = generate_exception_field
        format_json([attachment])
      end

      def build_run_failed_message
        # return the message as a hash
        {
          token: config['token'],
          channel: config['channel'],
          username: config['username'],
          icon_emoji: config['icon_emoji'],
          attachments: build_attachments_json
        }
      end

      def format_json(component)
        # format a slack msg
        Chef::JSONCompat.to_json_pretty(component)
      end

      def post_to_slack(msg)
        uri = URI('https://slack.com/api/chat.postMessage')
        uri.query = URI.encode_www_form(msg)
        req = Net::HTTP::Post.new(uri)
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |https|
          https.request(req)
        end
      end
    end
  end
end
