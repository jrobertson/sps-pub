#!/usr/bin/env ruby

# file: sps-pub.rb

require 'simplepubsub'

class SPSPub
  include SimplePubSub

  def self.notice(s,sps_address='sps',port='59000')

    topic, msg = s.split(/:\s*/,2)

    Client.connect(sps_address, port, options={}) do |client|

      opt = {stay_connected: false}.merge options
      puts "about to publish : topic: %s msg: %s" % [topic, msg]
      client.publish(topic, msg)
      :stop if opt[:stay_connected] == false
    end
    
  end
  
  def self.listen(topic='#', sps_address='sps')

    Client.connect(sps_address) do |client|
      client.get(topic) do |topic, message| 
        puts "[%s] SPS listener INFO %s: %s" % 
          [Time.now.strftime("%Y-%m-%d %H:%M"), topic, message]
      end
    end
  end  
end