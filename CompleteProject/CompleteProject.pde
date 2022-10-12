//----------------------------------------- //<>//
import javax.swing.JOptionPane; //<>//
//THIS IS A COMMENT
DataNode[] courseTiles;

int active = -1;
boolean[] multiSelect;
boolean highlighting = false;
int[] mousePos = new int[6];//0-1 highlight box; 2-5 for moving multiselect

void setup() {
  size(2500, 1400);
  strokeWeight(3);
  initcourseTiles();
}

void draw() {
  background(100); //Clear frame

  for (int i=0; i < courseTiles.length; i++) { //DrawNodes
  if (courseTiles[i]!=null) {

    courseTiles[i].drawNode();
  }
  }

  updateActive(); //Set mousePos variable

  if (highlighting) { //Update highlighting
    fill(100, 100, 100, 50);
    rect(mousePos[0], mousePos[1], mouseX-mousePos[0], mouseY-mousePos[1]);
  }

  mousePos[4]=mousePos[2]; //Change mouse positions
  mousePos[5]=mousePos[3];
  mousePos[2]=mouseX;
  mousePos[3]=mouseY;

  // for (int i=0; i < courseTiles.length; i++) { //Move multiSelect
  //   if (multiSelect[i]&&mousePressed&&mouseButton==LEFT) {
  //     println("CompleteProject.draw: " + (i));
  //     courseTiles[i].x += mousePos[2]-mousePos[4];
  //     courseTiles[i].y += mousePos[3]-mousePos[5];
  //   }
  // }

  //Draw DescriptionBox
  for (int i = 0; i < courseTiles.length; ++i) {
    courseTiles[i].showDescriptiom(mouseX, mouseY);
  }
}

//Initializer
void initcourseTiles() {
  ArrayList<Course> courses = new ArrayList<Course>();
  String[] lines = loadStrings("RawData.txt");
  
  //parse Data
  String newLine;
  String[] tokens;
  Course compCourse = null;
  for (int i = 0; i < lines.length; ++i) {
    {
      newLine = lines[i];
      tokens = newLine.trim().split("\\s+");

      if (tokens[0].equals("COMP"))
      {
          compCourse = new Course();
          courses.add(compCourse);
      }

      if (compCourse != null)
          compCourse.processData(tokens);
    }
  }
  
  //create DataNodes
  courseTiles = new DataNode[courses.size()];
  int i=0;
  for (Course course : courses) {
    courseTiles[i++]=(new DataNode(course, i));
  }
  for (i = 0; i < courseTiles.length; ++i) {
    courseTiles[i].getParents();
  }
  println("CompleteProject.initcourseTiles: "+courseTiles.length);
}

//mouseClick/released
void mousePressed() {
  mousePos[0] = mouseX;
  mousePos[1] = mouseY;
  mousePos[2] = mouseX;
  mousePos[3] = mouseY;
  mousePos[4] = mouseX;
  mousePos[5] = mouseY;

  println(mousePos[0]);
  if (mouseButton ==  LEFT) {
    for (int i = 0; i < courseTiles.length; i++) {
      float x = courseTiles[i].x;
      float y = courseTiles[i].y;
      if (mouseX > x &&  mouseX < x + 100 &&  mouseY > y &&  mouseY < y + 100) {
        active =i; 
        break;
      }
    }
  }
  if (mouseButton ==  RIGHT) {
    highlighting = true;
  }
}

void mouseReleased() {
  active = -1;
  if (highlighting) {
    highlighting = false;
    println("CompleteProject.mouseReleased: "+mousePos[0]);
    makeBox(mousePos[0], mousePos[1]);
  }
}

void updateActive() {
  if (active >=  0) {
    courseTiles[active].x = mouseX;
    courseTiles[active].y = mouseY;
  }
}

void keyPressed() {
  if (key ==  'p') {
    String exportString = "";
    for (int i = 0; i < courseTiles.length; i++) {
      exportString += courseTiles[i].x + ":" + courseTiles[i].y;
      exportString += ",";
    }
    exportString += "|";
    println("CompleteProject.keyPressed: "+exportString);
  }
  if (key ==  'o') {
    String impString = JOptionPane.showInputDialog("importString");
    int x = 0;
    int y = 0;
    String temp = "";
    int counter = 0;
    for (int i = 0; i < impString.length(); i++) {
      if (impString.charAt(i) ==  '|') {
        break;
      } else if (impString.charAt(i) ==  ':') {
        x = Integer.parseInt(temp);
        temp = "";
      } else if (impString.charAt(i) ==  ',') {
        y = Integer.parseInt(temp);
        temp = "";
        courseTiles[counter].x = x;
        courseTiles[counter++].y = y;
      } else {
        temp += impString.charAt(i);
      }
    }
  }
}

void makeBox(int boxX, int boxY) { //Allows users to highlight and move multiple DataNodes at once
  multiSelect = new boolean[courseTiles.length]; 
  for (int i = 0; i < courseTiles.length; i++) {
    int boxTop = min(boxY, mouseY);
    int boxBottom = max(boxY, mouseY);
    int boxLeft = min(boxX, mouseX);
    int boxRight = max(boxX, mouseX);
    int nodeTop = courseTiles[i].y;
    int nodeBottom = courseTiles[i].y + 100;
    int nodeLeft = courseTiles[i].x; 
    int nodeRight = courseTiles[i].x + 100;
    multiSelect[i] = (nodeRight>boxLeft &&  nodeLeft<boxRight &&  nodeTop<boxBottom &&  nodeBottom>boxTop);
  }
  //println(multiSelect);
}
