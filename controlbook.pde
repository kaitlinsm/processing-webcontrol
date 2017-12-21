import processing.net.*;

Server server;
Mode[] modes;
Mode activeMode;

void setup() {
  size(200, 200);
  server = new Server(this, 8010);
  modes = new Mode[] { new Mode('W', "Whiteout"), new Mode('R', "Red") };
  activeMode = modes[0];
}

public class Mode {
  public char control;
  private String name;
  
  public Mode(char control, String name) {
    this.control = control;
    this.name = name;
  }
  
  public String getModeConfig(Mode active) {
    String isActive = active == this ? "true" : "false";
    return "{ \"key\": \"" + control + "\", \"name\": \"" + name + "\", \"isActive\": " + isActive + " }";
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

void draw() {
  Client cli = server.available();
  if (cli != null) {
    String msg = cli.readString();
    println(msg);
    if (msg.indexOf("key:") > 0) {
      char keyPressed = msg.charAt(msg.indexOf("?key=") + 5);
      println("key pressed: ", keyPressed);
      
      for(int i = 0; i < modes.length; i++) {
        if (modes[i].control == keyPressed){
          activeMode = modes[i];
        }
      }
    }
    String response = buildResponse();
    
    cli.write("HTTP/1.1 200 OK\r\n");
    cli.write("Content-Type: text/x-json\r\n");
    cli.write("Access-Control-Allow-Origin: *\r\n");
    cli.write("Content-Length: " + response.length() + "\r\n");
    cli.write("\r\n");
    cli.write(response);
    
  }
}