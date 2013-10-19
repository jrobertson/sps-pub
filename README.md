# Subscribe or publish to a SimplePubSub broker in 1 line of code using the SPS-pub gem

## Publish example

    require 'sps-pub'

    # publish the message 'light on', with the topic 'fortina' 
    #   to the default SPS broker called 'sps'
    #
    SPSPub.notice 'fortina: light on'

## Subscribe example 1

    require 'sps-pub'

    # subscribe to all topics on the default SPS broker called 'sps'
    #
    SPSPub.listen

output:

    ...
    [2013-10-19 14:22] SPS listener INFO ralina: fire down 2
    [2013-10-19 14:22] SPS listener INFO xmpp_presence: james@jamesrobertson.eu/talkonaut-S60-3rd_5.71.17_3372124e:
    [2013-10-19 14:25] SPS listener INFO magic: testing 126 simplepubsub 

## Subscribe example 2

    require 'sps-pub'

    # subscribe to topic 'fortina' on the default SPS broker called 'sps'
    #
    SPSPub.listen 'fortina'

spspub sps gem listen notice
