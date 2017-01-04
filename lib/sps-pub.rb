#!/usr/bin/env ruby

# file: sps-pub.rb

require 'websocket-client-simple'


class SPSPub

  def initialize(host: 'sps', address: host, port: '59000')
    
    
    @client = WebSocket::Client::Simple.connect "ws://%s:%s/" % [address, port]    
    sleep 0.02

  end

  def notice(s)
    @client.send s
  end

  alias publish notice

  def self.notice(s, hostx='sps', host: hostx, address: host, 
                  port: '59000', retries: 3)


    ws = WebSocket::Client::Simple.connect "ws://%s:%s/" % [address, port]
     
    ws.on :open do    
      
      retry_attempts = 0      
      
      begin
        
        ws.send s
        
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
    
    sleep 0.01 # give the above message time to be sent
    
    :message_sent

  end

  def self.pub(s, address: 'sps', host: address, port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

  def self.publish(s, address: 'sps', host: address, port: '59000')
    self.notice(s, address: 'sps', port: '59000')
  end

end
