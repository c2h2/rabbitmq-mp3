#!/usr/bin/env ruby
# encoding: utf-8

require "amqp"
require "yaml"

SERVER = "localhost"
SSL = false
PORT = 5672

def get_content 
  content = File.read(ARGV[0])
end

AMQP.start(:host => SERVER, :ssl => SSL, :port => PORT) do |connection|
  channel  = AMQP::Channel.new(connection)
  exchange = channel.fanout("mp3")
  message  = get_content

  exchange.publish(message)
  puts "#{message.length} sent."

  EM.add_timer(0.5) do
    connection.close do
      EM.stop { exit }
    end
  end
end
