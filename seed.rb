#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require(:default)

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'whats_next'

include WhatsNext

list = ProjectList.new

p1 = Project.new("Wake up")
p1.tasks << Task.new("Listen for alarm", :foreground)
p1.tasks << Task.new("Get out of bed")
p1.tasks << Task.new("Take a shower")
p1.tasks << Task.new("Drive to work")

p2 = Project.new("Become Master Coder")
p2.tasks << Task.new("Do a kata", :foreground)
p2.tasks << Task.new("Write another kata")
p2.tasks << Task.new("Make an IRC bot")
p2.tasks << Task.new("Make a key-value store")

list.projects[p1.name] = p1
list.projects[p2.name] = p2

list.current_project = "Become Master Coder"

dump = Serializer.dump(list)
puts dump.inspect

string = "{\"current_project\":\"Become Master Coder\",\"projects\":{\"Wake up\":{\"name\":\"Wake up\",\"tasks\":[{\"text\":\"Listen for alarm\",\"status\":\"!\"},{\"text\":\"Get out of bed\",\"status\":\"-\"},{\"text\":\"Take a shower\",\"status\":\"-\"},{\"text\":\"Drive to work\",\"status\":\"-\"}]},\"Become Master Coder\":{\"name\":\"Become Master Coder\",\"tasks\":[{\"text\":\"Do a kata\",\"status\":\"!\"},{\"text\":\"Write another kata\",\"status\":\"-\"},{\"text\":\"Make an IRC bot\",\"status\":\"-\"},{\"text\":\"Make a key-value store\",\"status\":\"-\"}]}}}"

list2 = Serializer.load(string)
dump2 = Serializer.dump(list2)

puts "Matching? #{ dump == dump2 }"

puts Printer.print(list2)

Env::Redis.start!

Env.redis.set 'whats-next-plugin-markjosef_air-whats-next', dump