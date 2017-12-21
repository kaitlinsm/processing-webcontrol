# processing-webcontrol
Simple example web control interface for processing.org using bootstrap knockout and webpack

## The Problem ##
Processing.org is a great tool for making visualizations. Controlling
these programs requires physical access to the machine the sketch is running on.

This project aims to provide a web interface to allow any computer or phone on the network 
to be a remote control for whatever Processing sketch you want to connect it to.

It uses bootstrap and knockout to render the UI, making it pretty easy to customize.

At its core, the sketch defines a Mode.

## Instructions ##
You'll need node.js installed. Clone or unpack the zip, and from the directory in a command 
line run

    npm install
    webpack

And that should then do what you need. For debugging purposes, you can just double-click the 
index.html file and it'll open in your browser.

For deployment, the directory will need to be accessible from an HTTP server on the same 
machine that the sketch is running on.