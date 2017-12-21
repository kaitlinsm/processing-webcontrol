# processing-webcontrol
Simple example web control interface for processing.org using bootstrap knockout and webpack

## The Problem ##
Processing.org is a great tool for quickly and simply making visualizations. Controlling
these tools requires physical access to a keyboard on the machine.

This project aims to provide a web interface to allow any computer or phone on the network 
to be a remote control for whatever Processing sketch you want to connect it to.

It uses bootstrap and knockout to render the UI, making it pretty easy to customize.

## Instructions ##
You'll need node.js installed. Clone or unpack the zip, and from the directory in a command 
line run

    npm install

that should then do what you need. The directory will need to be accessible from an HTTP server
on the same machine that the sketch is running on.
