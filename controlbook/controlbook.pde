import processing.net.*;

Server server;
Mode[] modes;
Mode activeMode;

void setup() {
  size(200, 200);
  
  // the server listens on port 8010 for a very small set of commands
  server = new Server(this, 8010);

  // the modes are analogous to program selections.
  modes = new Mode[] { 
    new Mode('R', "Red",   0xFF0101), 
    new Mode('G', "Green", 0x01FF01), 
    new Mode('B', "Blue",  0x0101FE)
  };
  activeMode = modes[0];
  activeMode.setColour();
}

public class Mode {
  private char control;
  private String name;
  private int colour;
  
  public Mode(char control, String name, int colour) {
    this.control = control;
    this.name = name;
    this.colour = colour;
  }
  
  public String getModeConfig(Mode active) {
    String isActive = active == this ? "true" : "false";
    return "{ \"key\": \"" + control + "\", \"name\": \"" + name + "\", \"isActive\": " + isActive + " }";
  }

  // returns true if the key pressed matches the control key of this mode
  public boolean controlKeyMatches(char keyPressed) {
    return control == keyPressed;
  }

  // draws the colour for this mode.
  public void setColour() {
    background(colour, 1.0);
  }
}


String buildResponse() {
  StringBuilder rb = new StringBuilder();
  rb.append("[\r\n");
  for(int i = 0; i < modes.length; i++) {
    rb.append("  " + modes[i].getModeConfig(activeMode));
    if (i < modes.length - 1){
      rb.append(",");
    }
    rb.append("\r\n");
  }
  rb.append("]");
  
  return rb.toString();
}

// the keyPressed event handler - so we can understand the keyboard input
void keyPressed() {
  char keyPressed = (char)keyCode;
  handleKeyPressed(keyPressed);
}

void handleKeyPressed(char keyPressed) {
  println("key pressed: ", keyPressed);
  
  // find whatever mode matches the key that was pressed or sent from the web
  for(int i = 0; i < modes.length; i++) {
    if (modes[i].controlKeyMatches(keyPressed)){
      activeMode = modes[i];
    }
  }
  // set whatever colour was selected
  activeMode.setColour();
}

void draw() {
  Client cli = server.available();
  if (cli != null) {
    String msg = cli.readString();
    println(msg);

    if (msg.indexOf("?key=") > 0) {
      char keyPressed = msg.charAt(msg.indexOf("?key=") + 5);
      // use the same handleKeyPressed() function as when you actually press
      // a key
      handleKeyPressed(keyPressed);
    }

    // the response contains the status of the program - how many modes there
    // are, which mode is selected etc. This allows the UI to update with the
    // status of this sketch.
    String response = buildResponse();

    // send the response back as a very simple JSON HTTP response
    cli.write("HTTP/1.1 200 OK\r\n");
    cli.write("Content-Type: text/x-json\r\n");
    cli.write("Access-Control-Allow-Origin: *\r\n");
    cli.write("Content-Length: " + response.length() + "\r\n");
    cli.write("\r\n");
    cli.write(response);
  }
}

void stop() {
  println("stopping");
  server.stop();
}