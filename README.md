# processing-webcontrol
Simple example web control interface for processing.org using bootstrap knockout and webpack

## The Problem ##
Processing.org is a great tool for making visualizations. Controlling
these programs requires physical access to the machine the sketch is running on.

This project demonstrates a web interface to allow any computer or phone on the network 
to be a remote control for whatever Processing sketch you want to connect it to.

It uses bootstrap and knockout to render the UI, making it pretty easy to customize.

## What it does ##

At its core, the sketch defines a Mode as "a thing that makes the screen go a colour". To begin
with, the web interface doesn't know about what exact modes are defined in the Sketch.

So what the sketch does is respond to any request made by the web interface with a list
of all modes and which one is on or off.

The sketch setup defines three colours (r, g, b). Once running, you can either type "R" "G" or "B"
on the keyboard when the sketch window is active, or you can click the buttons on the web
interface that correspond.

The active mode will show on the button that was clicked.

## Instructions ##
Run the controllbook.pde sketch in processing.

For debugging purposes, you can just double-click the index.html file and it'll open in your browser.

For deployment, the directory will need to be accessible from an HTTP server on the same 
machine that the sketch is running on. You can do this in many ways but that's a different
story altogether.