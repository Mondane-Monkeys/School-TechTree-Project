//-----------------------------------------
import javax.swing.JOptionPane; //<>// //<>//




String[] tags = {
  "STAT1000", "MATH1300", "MATH1240", "MATH1500", "COMP1010", "COMP1012", "COMP1020", "COMP1500", "COMP1600", "COMP2080", "COMP2130", "COMP2140", "COMP2150", "COMP2160", "COMP2190", "COMP2280", "COMP2980", "COMP3010", "COMP3020", "COMP3030", "COMP3040", "COMP3090", "COMP3170", "COMP3190", "COMP3290", "COMP3350", "COMP3370", "COMP3380", "COMP3430", "COMP3440", "COMP3490", "COMP3820", "COMP3980", "COMP4020", "COMP4050", "COMP4060", "COMP4140", "COMP4180", "COMP4190", "COMP4200", "COMP4300", "COMP4340", "COMP4350", "COMP4360", "COMP4380", "COMP4420", "COMP4430", "COMP4490", "COMP4510", "COMP4520", "COMP4550", "COMP4560", "COMP4580", "COMP4620", "COMP4690", "COMP4710", "COMP4740", "COMP4980", "COMP4990"
};
String[][] preReqs = {
  {}, {}, {}, {}, {}, {"MATH1500"}, {"COMP1010"}, {}, {}, {"MATH1240", "COMP2140"}, {"MATH1300", "MATH1500"}, {"COMP1020"}, {"COMP2160", "COMP2140"}, {"COMP1020"}, {"COMP1020", "MATH1500", "MATH1300"}, {"COMP2140", "COMP2160", "MATH1240"}, {}, {"COMP2150"}, {"COMP2140"}, {"COMP2080"}, {}, {"COMP2280"}, {"COMP2140", "COMP2080"}, {"COMP2140"}, {"COMP2140", "COMP2280"}, {"COMP2150"}, {"COMP2280"}, {"COMP2140"}, {"COMP2140", "COMP2280"}, {"COMP2140"}, {"COMP2140", "COMP2190"}, {"COMP2080"}, {"COMP2980"}, {"COMP3020"}, {"COMP3350"}, {}, {"COMP3170"}, {"COMP2160", "COMP3190"}, {"COMP3190"}, {"COMP3190"}, {"COMP2280", "COMP3010"}, {"COMP3170"}, {"COMP3350"}, {"COMP3190"}, {"COMP3380"}, {"COMP3170", "STAT1000"}, {"COMP2160", "COMP3430"}, {"COMP3490"}, {"COMP3370", "COMP3430"}, {}, {"COMP3430", "COMP3370"}, {"COMP3350"}, {"COMP3430", "COMP3010"}, {}, {"COMP3370"}, {"COMP3380"}, {"COMP3380"}, {"COMP3980"}, {"COMP4980"}
};
String[] title = {
  "Intro to Stats", "Linear Algebra", "Discrete Math", "Calc", "Introductory Computer Science 1  3 cr  ", "Computer Programming for Scientists and Engineers  3 cr  ", "Introductory Computer Science 2  3 cr  ", "Computing: Ideas and Innovation  3 cr  ", "Navigating Your Digital World  3 cr  ", "Analysis of Algorithms  3 cr  ", "Discrete Mathematics for Computer Science  3 cr  ", "Data Structures and Algorithms  3 cr  ", "Object Orientation  3 cr  ", "Programming Practices  3 cr  ", "Introduction to Scientific Computing  3 cr  ", "Introduction to Computer Systems  3 cr  ", "Workterm 1  0 cr  ", "Distributed Computing  3 cr  ", "Human-Computer Interaction 1  3 cr  ", "Automata Theory and Formal Languages  3 cr  ", "Technical Communication in Computer Science  3 cr  ", "Digital Logic 2  3 cr  ", "Analysis of Algorithms and Data Structures  3 cr  ", "Introduction to Artificial Intelligence  3 cr  ", "Introduction to Compiler Construction  3 cr  ", "Software Engineering 1  3 cr  ", "Computer Organization  3 cr  ", "Databases Concepts and Usage  3 cr  ", "Operating Systems  3 cr  ", "Programming Language Concepts  3 cr  ", "Computer Graphics 1  3 cr  ", "Introduction to Bioinformatics Algorithms  3 cr  ", "Workterm 2  0 cr  ", "Human-Computer Interaction 2  3 cr  ", "Project Management  3 cr  ", "Topics in Computer Science  3 cr  ", "Introduction to Cryptography and Cryptosystems  3 cr  ", "Intelligent Mobile Robotics  3 cr  ", "Artificial Intelligence  3 cr  ", "Expert Systems  3 cr  ", "Computer Networks  3 cr  ", "Graph Theory Algorithms 1  3 cr  ", "Software Engineering 2  3 cr  ", "Machine Learning  3 cr  ", "Database Implementation  3 cr  ", "Advanced Design and Analysis of Algorithms  3 cr  ", "Operating Systems 2  3 cr  ", "Computer Graphics 2  3 cr  ", "Introduction to Parallel Computation  3 cr  ", "Undergraduate Honours Project  3 cr  ", "Real-Time Systems  3 cr  ", "Industrial Project  3 cr  ", "Computer Security  3 cr  ", "Professional Practice in Computer Science  3 cr  ", "Computer Systems and Architecture  3 cr  ", "Introduction to Data Mining  3 cr  ", "Advanced Databases  3 cr  ", "Workterm 3  0 cr  ", "Workterm 4  0 cr  "
};

String[] sTags = {
  "STAT1000", "MATH1300", "MATH1240", "MATH1500", "COMP1010", "COMP1012", "COMP1020", "COMP1500", "COMP1600", "COMP2080", "COMP2130", "COMP2140", "COMP2150", "COMP2160", "COMP2190", "COMP2280", "COMP2980", "COMP3010", "COMP3020", "COMP3030", "COMP3040", "COMP3090", "COMP3170", "COMP3190", "COMP3290", "COMP3350", "COMP3370", "COMP3380", "COMP3430", "COMP3440", "COMP3490", "COMP3820", "COMP3980", "COMP4020", "COMP4050", "COMP4060", "COMP4140", "COMP4180", "COMP4190", "COMP4200", "COMP4300", "COMP4340", "COMP4350", "COMP4360", "COMP4380", "COMP4420", "COMP4430", "COMP4490", "COMP4510", "COMP4520", "COMP4550", "COMP4560", "COMP4580", "COMP4620", "COMP4690", "COMP4710", "COMP4740", "COMP4980", "COMP4990"
};
String[][] sPreReqs = {
  {}, {}, {}, {}, {}, {"MATH1500"}, {"COMP1010"}, {}, {}, {"MATH1240", "COMP2140"}, {"MATH1300", "MATH1500"}, {"COMP1020"}, {"COMP2160", "COMP2140"}, {"COMP1020"}, {"COMP1020", "MATH1500", "MATH1300"}, {"COMP2140", "COMP2160", "MATH1240"}, {}, {"COMP2150"}, {"COMP2140"}, {"COMP2080"}, {}, {"COMP2280"}, {"COMP2080"}, {"COMP2140"}, {"COMP2280"}, {"COMP2150"}, {"COMP2280"}, {"COMP2140"}, {"COMP2280"}, {"COMP2140"}, {"COMP2140", "COMP2190"}, {"COMP2080"}, {"COMP2980"}, {"COMP3020"}, {"COMP3350"}, {}, {"COMP3170"}, {"COMP2160", "COMP3190"}, {"COMP3190"}, {"COMP3190"}, {"COMP2280", "COMP3010"}, {"COMP3170"}, {"COMP3350"}, {"COMP3190"}, {"COMP3380"}, {"COMP3170", "STAT1000"}, {"COMP3430"}, {"COMP3490"}, {"COMP3370", "COMP3430"}, {}, {"COMP3430", "COMP3370"}, {"COMP3350"}, {"COMP3430", "COMP3010"}, {}, {"COMP3370"}, {"COMP3380"}, {"COMP3380"}, {"COMP3980"}, {"COMP4980"}, 
};
String[] sTitle = {
  "Intro to Stats", "Linear Algebra", "Discrete Math", "Calc", "Introductory Computer Science 1  3 cr  ", "Computer Programming for Scientists and Engineers  3 cr  ", "Introductory Computer Science 2  3 cr  ", "Computing: Ideas and Innovation  3 cr  ", "Navigating Your Digital World  3 cr  ", "Analysis of Algorithms  3 cr  ", "Discrete Mathematics for Computer Science  3 cr  ", "Data Structures and Algorithms  3 cr  ", "Object Orientation  3 cr  ", "Programming Practices  3 cr  ", "Introduction to Scientific Computing  3 cr  ", "Introduction to Computer Systems  3 cr  ", "Workterm 1  0 cr  ", "Distributed Computing  3 cr  ", "Human-Computer Interaction 1  3 cr  ", "Automata Theory and Formal Languages  3 cr  ", "Technical Communication in Computer Science  3 cr  ", "Digital Logic 2  3 cr  ", "Analysis of Algorithms and Data Structures  3 cr  ", "Introduction to Artificial Intelligence  3 cr  ", "Introduction to Compiler Construction  3 cr  ", "Software Engineering 1  3 cr  ", "Computer Organization  3 cr  ", "Databases Concepts and Usage  3 cr  ", "Operating Systems  3 cr  ", "Programming Language Concepts  3 cr  ", "Computer Graphics 1  3 cr  ", "Introduction to Bioinformatics Algorithms  3 cr  ", "Workterm 2  0 cr  ", "Human-Computer Interaction 2  3 cr  ", "Project Management  3 cr  ", "Topics in Computer Science  3 cr  ", "Introduction to Cryptography and Cryptosystems  3 cr  ", "Intelligent Mobile Robotics  3 cr  ", "Artificial Intelligence  3 cr  ", "Expert Systems  3 cr  ", "Computer Networks  3 cr  ", "Graph Theory Algorithms 1  3 cr  ", "Software Engineering 2  3 cr  ", "Machine Learning  3 cr  ", "Database Implementation  3 cr  ", "Advanced Design and Analysis of Algorithms  3 cr  ", "Operating Systems 2  3 cr  ", "Computer Graphics 2  3 cr  ", "Introduction to Parallel Computation  3 cr  ", "Undergraduate Honours Project  3 cr  ", "Real-Time Systems  3 cr  ", "Industrial Project  3 cr  ", "Computer Security  3 cr  ", "Professional Practice in Computer Science  3 cr  ", "Computer Systems and Architecture  3 cr  ", "Introduction to Data Mining  3 cr  ", "Advanced Databases  3 cr  ", "Workterm 3  0 cr  ", "Workterm 4  0 cr  "
};



DataNode[] courses;

String[] test = {"MATH1", "MATH2", "MATH3"};//tag
String[] testD = {"The first", "The Second", "The Third", };//name
String[][] testPre = {{}, {"MATH1"}, {"MATH1", "MATH2"}};//prereqs


int active = -1;
boolean[] multiSelect;
boolean highlighting = false;
int[] mousePos = new int[6];//0-1 highlight box; 2-5 for moving multiselect

void setup() {
  size(2500, 1400);
  strokeWeight(3);
  println("Messy Arrays lengths: "+tags.length+" " +preReqs.length+ " " +title.length);
  println("simple Arrays lengths: "+sTags.length+" " +sPreReqs.length+ " " +sTitle.length);
  courses = new DataNode[tags.length];
  multiSelect = new boolean[courses.length];
  //initCourses(tags,title,preReqs);
  initCourses(sTags, sTitle, sPreReqs);
}

void draw() {
  background(100); //Clear frame
  
  for (int i=0; i < courses.length; i++) { //DrawNodes
    courses[i].drawNode();
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
  
  for (int i=0; i < courses.length; i++) { //Move multiSelect
    if (multiSelect[i]&&mousePressed&&mouseButton==LEFT) {
      println("multSelectMoveQuaant: " + (i));
      courses[i].x += mousePos[2]-mousePos[4];
      courses[i].y += mousePos[3]-mousePos[5];
    }
  }
  
  //Draw DescriptionBox
  for (int i = 0; i < courses.length; ++i) {
    courses[i].showDescriptiom(mouseX, mouseY);
  }
}

//mouseClick/released
void mousePressed() {
  mousePos[0]=mouseX;
  mousePos[1]=mouseY;
  mousePos[2]=mouseX;
  mousePos[3]=mouseY;
  mousePos[4]=mouseX;
  mousePos[5]=mouseY;

  println(mousePos[0]);
  if (mouseButton==LEFT) {
    for (int i=0; i < courses.length; i++) {
      float x = courses[i].x;
      float y = courses[i].y;
      if (mouseX>x&&mouseX<x+100&&mouseY>y&&mouseY<y+100) {
        active = i; 
        break;
      }
    }
  }
  if (mouseButton==RIGHT) {
    highlighting = true;
  }
}

void mouseReleased() {
  active = -1;
  if (highlighting) {
    highlighting=false;
    println(mousePos[0]);
    makeBox(mousePos[0], mousePos[1]);
  }
}

void updateActive() {
  if (active>=0) {
    courses[active].x = mouseX;
    courses[active].y = mouseY;
  }
}

void keyPressed() {
  if (key=='p') {
    String exportString = "";
    for (int i=0; i < courses.length; i++) {
      exportString += courses[i].x + ":" + courses[i].y;
      exportString+=",";
    }
    exportString+="|";
    println(exportString);
  }
  if (key=='o') {
    String impString = JOptionPane.showInputDialog("importString");
    int x = 0;
    int y = 0;
    String temp = "";
    int counter = 0;
    for (int i=0; i < impString.length(); i++) {
      if (impString.charAt(i)=='|') {
        break;
      } else if (impString.charAt(i)==':') {
        x=Integer.parseInt(temp);
        temp="";
      } else if (impString.charAt(i)==',') {
        y=Integer.parseInt(temp);
        temp="";
        courses[counter].x = x;
        courses[counter++].y = y;
      } else {
        temp+=impString.charAt(i);
      }
    }
  }
}


void initCourses(String[] tags, String[] title, String[][] preReqs) {
  for (int i=0; i < tags.length; i++) {
    courses[i] = new DataNode(tags[i], title[i], preReqs[i], i);
  }
  for (int i=0; i < courses.length; i++) {
    courses[i].getParents();
  }
}

void makeBox(int boxX, int boxY) {
  multiSelect = new boolean[courses.length]; 
  for (int i=0; i < courses.length; i++) {
    int boxTop = min(boxY, mouseY);
    int boxBottom = max(boxY, mouseY);
    int boxLeft = min(boxX, mouseX);
    int boxRight = max(boxX, mouseX);
    int nodeTop = courses[i].y;
    int nodeBottom = courses[i].y+100;
    int nodeLeft = courses[i].x; 
    int nodeRight = courses[i].x+100;
    multiSelect[i] = (nodeRight>boxLeft&&nodeLeft<boxRight&&nodeTop<boxBottom&&nodeBottom>boxTop);
  }
  //println(multiSelect);
}

//---------------------------------------------------------------

class DataNode {
  int ID;//position in main array
  String tag;//course ID like COMP1010
  String name; //course name like introducory computer Science
  String[] preReqs; //list of course prerequists by tag
  String description = "This is the default description, and is simply used as a placeholder for a more specific description. It does not matter what is here, only that it is sufficiently long for testing purposes. That includes The spaces and the punctuation. Honestly, I could just add jibberish to this and it would be fine. So instead I thought I would leave a little note here for whoever reads this lol. Frankly I think this is long enough, but who knows? Maybe it should be longer. Some of those courses might have a long description.";
  int[] parentIDs;
  int x = 100;
  int y = 100;
  int dnWidth = 100;
  int dnHeight = 100;
  color colour = color(0, 255, 255);
  color colour2 = color (random(150), random(150), random(150));

  DataNode(String tag, String name, String[] preReqs, int test) {
    this.ID = test;
    this.tag=tag;
    this.name=name;
    this.preReqs=preReqs;
    this.x = 0;
    this.y = 0;
    this.dnWidth = 100;
    this.dnHeight = 100;
    //this.x = 110*(test%9);
    //this.y = 110*(test/9);
  }

  //find parents ID from tag
  void getParents() {
    parentIDs = new int[preReqs.length];
    int counter =0;
    for (int j=0; j < courses.length; j++) {
      if (isParent(courses[j])) {
        parentIDs[counter++] = j;
      }
    }
  }

  boolean isParent(DataNode dn) {
    boolean returnVal = false;
    String parentTag = dn.tag;
    for (int i=0; i < preReqs.length; i++) {
      if (parentTag.equals(preReqs[i])) {
        returnVal=true;
      }
    }
    return returnVal;
  }

  //draw
  void drawNode() {
    //rect
    fill(colour);
    rect(x, y, 100, 100);
    placeText(""+ID, x, y, 20, 20);//ID
    placeText(tag, x+22, y, 70, 20);//Tag
    placeText(name, x, y+22, 98, 75);//Title

    //Lines
    for (int i=0; i < parentIDs.length; i++) {
      line(x+50, y, courses[parentIDs[i]].x+50, courses[parentIDs[i]].y+100);
    }
  }

  void placeText(String s, int x, int y, int w, int h) {
    fill(colour2);
    rect(x, y, w, h);
    fill(255);
    stroke(255);
    float tWidth = textWidth(s);
    float tHeight = textAscent()+textDescent();
    float yPos = h/2 + tHeight/2 + y;
    float xPos = x + w/2 - tWidth/2;
    text(s, xPos, yPos);
  }
  
  void showDescriptiom(int inMouseX, int inMouseY){
    if (isIn(inMouseX, inMouseY)){
      drawDesc(inMouseX, inMouseY);
    }
  }
  
  boolean isIn(int inMouseX, int inMouseY){
    if (inMouseX>x && inMouseX<(x+dnWidth) && inMouseY>y && inMouseY<(y+dnHeight)) {
      return true;
    }
    return false;
  }
  
  void drawDesc(int inMouseX, int inMouseY) {
    
    int headerHeight = 20;
    int hTextSize = 16;
    int hMargin = 2;
    int lineBreak = hTextSize+2*hMargin;
    int maxDescLines = 4;
    
    int minDescriptionWidth = (int)textWidth(description)/maxDescLines;
    
    int descWidth = Math.max(minDescriptionWidth, Math.max(200, (int)textWidth(name)));
    int NumLineCount = (1+(int)textWidth(description)/descWidth)+(6);//'6' is used to get it to work lol. It accounts for blank space and the title,
    
    int descHeight = Math.max(200, NumLineCount*(hTextSize+2*hMargin));
    
    println(width,descWidth);
    
    inMouseX = Math.min(inMouseX, width-descWidth);//prevent overflow
    inMouseX = Math.max(inMouseX, 0);//prevent underflow
    inMouseY = Math.min(inMouseY, height-descHeight);//prevent overflow
    inMouseY = Math.max(inMouseY, 0);//prevent underflow
    
    //Main box
    fill(203, 180, 126);
    stroke(0);
    rect(inMouseX, inMouseY, descWidth, descHeight);
    
    //header
    fill(204, 131, 35);
    noStroke();
    rect(inMouseX, inMouseY, descWidth, headerHeight);
    
    //put text inside header.
    textSize(hTextSize);
    fill(0);
    text(tag+" - " +name, inMouseX+hMargin, inMouseY+hTextSize+hMargin);
    
    //put text inside Description
    int line = 2;
    String Pre = "";
    for(int i = 0; i<preReqs.length; ++i){
      Pre += preReqs[i]+" ";
    }
    text(description+"\n\n"+Pre, inMouseX+hMargin, inMouseY+hTextSize*line+hMargin*line, descWidth, descHeight);
  }
  
  
}
