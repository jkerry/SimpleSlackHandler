
Simple Slack Handler Cookbook
================

A handler to report run failures to slack with minimal gem dependencies
![Alt text](/screencap.png?raw=true "A Slack Alert")
Platforms
---------
Any platform should be fine since the recipe is nearly pure ruby but these are
the tested platforms thus far:

* Windows
* Ubuntu

Cookbooks
---------

The following cookbooks are dependencies:

* `chef_handler`


Recipes
=======

default
-------
Installs and activates the simple slack handler at compile time.

Usage
=====
1. configure the following attributes
  ```
  # required attributes
  default['handler']['slack']['channel'] = '#channel'
  default['handler']['slack']['token'] = 'SLACK_API_KEY'
  # optional attributes
  default['handler']['slack']['username'] = 'Simple Slack Handler'
  default['handler']['slack']['icon_emoji'] = ':rotating_light:'
  ```
2. add the default recipe to your runlist
