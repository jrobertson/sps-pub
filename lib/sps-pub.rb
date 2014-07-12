#!/usr/bin/env ruby

# file: sps-pub.rb

require 'simplepubsub'
require 'ws' # from gem 'simpleblockingwebsocketclient'


class SPSPub
  include SimplePubSub

  def initialize(address: 'sps', port: '59000')
    @client = Net::WS.new "ws://%s:%s/" % [address, port]
  end

  def notice(s)
    @client.send s
  end

  alias publish notice

  def self.notice(s, address: 'sps', port: '59000')

    client = Net::WS.new "ws://%s:%s/" % [address, port]
    client.send s
  end

  def self.pub(s, address: 'sps', port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

  def self.publish(s, address: 'sps', port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

  
  def self.listen(topic='#', address: 'sps')

    Client.connect(address) do |client|
      client.get(topic) do |topic, message| 
        puts "[%s] SPS listener INFO %s: %s" % 
          [Time.now.strftime("%Y-%m-%d %H:%M"), topic, message]
      end
    end
  end

  def self.subscribe(topic='#', address: 'sps')
    self.listen(topic='#', address: 'sps')
  end  
  
end