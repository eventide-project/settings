require 'bundler'
Bundler.setup

lib_dir = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

ENV['SETTINGS_FILE'] = File.expand_path('../test/spec/settings', __FILE__)

require 'settings'
