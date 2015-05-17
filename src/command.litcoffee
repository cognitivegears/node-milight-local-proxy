command.litcoffee
=================

This is the main command dispatcher for node-milight-local-proxy.  
This class is responsible for listening to UDP for mi-light commands 
(both admin and led commands) and dispatching them to the 
appropriate functions.

Copyright
=========

Copyright (c) 2015 Nathan Byrd. All Rights Reserved.

This file is part of node-milight-local-proxy.

node-milight-local-proxy is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

node-milight-local-proxy is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with node-milight-local-proxy.  If not, see 
[gnu.org](http://www.gnu.org/licenses/).

Code
====

First, lets set some default values for mi-light functionality

Server settings
---------------

Change these settings as needed to match your configuration.

The following controls the port and IP address the proxy listens on.

    ADMIN_PORT = 48899
    PROXY_PORT = 8899
    ADMIN_UDP_IP = ''
    PROXY_UDP_IP = ''

Data used for discovery of the proxy on the local network
*TODO*: Make these options or pull automatically?

    INT_IP = '10.0.1.29'
    INT_MAC = '001413007ced'

Serial settings
---------------

Change these settings as needed to match your configuration.

    TTL_PORT = "/dev/ttyAMA0"
    TTL_SPEED = 9600

Server setup
------------

Use the dgram module and create a udp4 socket for listening

    dgram = require 'dgram'

Use the serialport module to be able to communicate with the mi-light module.
*TODO*: Support a bridge mode for people who haven't hacked the hardware

    SerialPort = require("serialport").SerialPort
    serial = new SerialPort TTL_PORT, {baudrate: TTL_SPEED}

Define a main runWith() module to handle the server creation - 
dispatched from the main node-milight-local-proxy.js executable

    exports.runWith = (args) ->

First, create a server for the admin response.  This doesn't do 
much, just responds with the IP and MAC for discovery

      adminServer = dgram.createSocket 'udp4'
      adminServer.on "message", (msg, rinfo) ->

When we get a message, log the message, then create a return message based off 
what we receive.  The responses are:

* Link\_Wi-Fi => IP,MAC,
* Anything else => +ok

        console.log "server got: " + msg
        if msg.toString("utf-8").indexOf("Link_Wi-Fi") isnt -1
          returnString = INT_IP + ',' + INT_MAC + ','
        else
          returnString = "+ok"
        returnBuffer = new Buffer returnString, "utf-8"
        adminServer.send returnBuffer, 0, returnBuffer.length, \
        rinfo.port, rinfo.address

Bind to the address and port.  If we do not have an IP set, use the 
one-argument form of bind.


      if ADMIN_UDP_IP is ''
        adminServer.bind ADMIN_PORT
      else
        adminServer.bind ADMIN_PORT, ADMIN_UDP_IP

Now setup the proxy server, similar to the adminServer

    proxyServer = dgram.createSocket 'udp4'

Simply copy any messages we receive to the bridge - this works as a straight 
passthrough, the proxy doesn't do anything with the message itself.

    proxyServer.on "message", (msg, rinfo) ->
      serial.write msg

Bind to the address and port.  If we do not have an IP set, use the 
one-argument form of bind.

    if PROXY_UDP_IP is ''
      proxyServer.bind PROXY_PORT
    else
      proxyServer.bind PROXY_PORT, PROXY_UDP_IP
