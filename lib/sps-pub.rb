#!/usr/bin/env ruby

# file: sps-pub.rb

require 'simplepubsub'
require 'mqtt'

class SPSPub
  include SimplePubSub

  def self.notice(s,sps_address='sps', mqtt_address='mqtt')

    topic, msg = s.split(/:\s*/,2)
    r = ''

    Client.connect(sps_address) do |client|
      r = client.publish(topic, msg)
    end
    
    if topic == 'xmpp' then
      MQTT::Client.connect(mqtt_address) do |client|
        client.publish(topic, msg)
      end
    end
    r
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
