#!/usr/bin/env ruby

# file: sps-pub.rb

require 'websocket-client-simple'


class SPSPubError < Exception
end


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
                  port: '59000', retries: 3, hosts: [])


    ws = nil
    begin

      if hosts.any? then
        address, portx = hosts.first.split(':', 2)

        portx ||= port
        port = portx
      end

      ws = WebSocket::Client::Simple.connect "ws://%s:%s/" % [address, port]
    rescue Errno::ECONNREFUSED => e
      
      if hosts.any? then
        hosts.rotate!
        puts 'retrying ...' + hosts.inspect
        sleep 0.1
        #self.notice s, hosts: hosts.rotate
        retry
      else
        raise SPSPubError, "connection refused"
      end
      
    end
     
    ws.on :open do    
      
      retry_attempts = 0      
      
      begin
        
        ws.send s
      
      #exception

      rescue Exception => e
        puts 'dig it'
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
