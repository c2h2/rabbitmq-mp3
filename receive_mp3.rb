#!/usr/bin/env ruby
# encoding: utf-8

require "amqp"
SERVER = "localhost"
SSL = false
PORT = 5672


AMQP.start(:host => SERVER, :ssl => SSL, :port => PORT)  do |connection|
  channel  = AMQP::Channel.new(connection)
  exchange = channel.fanout("mp3")
  queue    = channel.queue("", :exclusive => true)

  queue.bind(exchange)

  Signal.trap("INT") do
    connection.close do
      EM.stop { exit }
    end
  end

  puts " [*] Waiting for logs. To exit press CTRL+C"

  queue.subscribe do |body|
    puts "#{body.length} received, playing"
    f=File.open("/tmp/hello.mp3", "w"){|f| f.write body}
    sleep 0.2
    `mpg123 /tmp/hello.mp3`
  end
end

