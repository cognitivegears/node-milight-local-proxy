# node-milight-local-proxy
Raspberry Pi Light control software for the mi-light/LimitlessLED/EasyBulb systems
  
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
along with node-milight-local-proxy.  If not, see [gnu.org](http://www.gnu.org/licenses/).

Description
===========

node-milight-local-proxy has been created as a replacement bridge for the 
mi-light/LimitlessLED/EasyBulb systems.  Currently this requires a specific 
software hack in order to access the bulbs from Raspberry PI, see 
[LimitlessLED WiFi Bridge 4.0 Conversion to Raspberry Pi](http://servernetworktech.com/2014/09/limitlessled-wifi-bridge-4-0-conversion-raspberry-pi/)
 for more information about how this hardware hack is setup.  In the future 
this module may support additional mechanisms for connecting to the 
mi-light system, some ideas include acting as a straight proxy to existing 
bridge or using a hardware device, such as NRF24L01? and arduino to create 
our own.

Currently this module has the same functionality as the standard bridge.  
Future functionality includes:

* REST API for controlling the lights
* Responsive web front-end for API
* Other compatibility APIs?

Building
========

On the Raspberry Pi, node-milight-local-proxy has been tested with the Raspbian distribution.  

To install the module, use the following:

1. Install a recent node.js - I built from source
2. Run `sudo npm install -g node-milight-local-proxy`
3. Startup using `milight-proxy`

*NOTE* I had some trouble with installing on Raspberry PI due to permissions 
issues with the serialport dependency.  If you get an error about serialport, 
try `sudo npm install -g node-milight-local-proxy --unsafe-perm` instead.

To setup a development environment, use the following:

1. Install a recent node.js - I built from source
2. Clone this repo
3. install grunt-cli: `sudo npm install -g grunt-cli`
4. Run `grunt` to compile the coffeescript
5. Execute `./node-milight-local-proxy.js`
