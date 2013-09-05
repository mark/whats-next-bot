#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require(:default)

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'whats_next'

Env::Redis.start!
Env::Bot.start!
