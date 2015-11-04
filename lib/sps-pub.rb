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

  def self.notice(s, host='sps', address: host, port: '59000', retries: 3)

    retry_attmpts = 0
    client = Net::WS.new "ws://%s:%s/" % [host, port]    
    
    begin
      
      client.send s
      
    rescue Errno::ETIMEDOUT => e
      
      if retries and retry_attempts < retries then
        
        retries += 1
        puts 'SPSPub timeout retrying ...'
        retry
        
      else
        puts 'SPSPub timeout while trying to contact the host'        
      end
      
    end

  end

  def self.pub(s, address: 'sps', port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

  def self.publish(s, address: 'sps', port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

end