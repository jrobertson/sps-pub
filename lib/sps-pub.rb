#!/usr/bin/env ruby

# file: sps-pub.rb

require 'ws'


class SPSPub

  def initialize(address: 'sps', port: '59000')
    @client = Net::WS.new "ws://%s:%s/" % [address, port]
  end

  def notice(s)
    @client.send s
  end

  alias publish notice

  def self.notice(s, host='sps', address: host, port: '59000')

    client = Net::WS.new "ws://%s:%s/" % [host, port]
    client.send s
  end

  def self.pub(s, address: 'sps', port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

  def self.publish(s, address: 'sps', port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

end
