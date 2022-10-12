class DataNode {
  int ID;//position in main array
  String tag;//course ID like COMP1010
  String name; //course name like introducory computer Science
  String[] preReqs; //list of course prerequists by tag
  String description = "This is the default desccourseTilesription, and is simply used as a placeholder for a more specific description. It does not matter what is here, only that it is sufficiently long for testing purposes. That includes The spaces and the punctuation. Honestly, I could just add jibberish to this and it would be fine. So instead I thought I would leave a little note here for whoever reads this lol. Frankly I think this is long enough, but who knows? Maybe it should be longer. Some of those courseTiles might have a long description.";
  int[] parentIDs;
  int x = 100;
  int y = 100;
  int dnWidth = 100;
  int dnHeight = 100;
  color colour = color(0, 255, 255);
  color colour2 = color (random(150), random(150), random(150));

  // DataNode(String tag, String name, String[] preReqs, int test) {
  //   this.ID = ID;
  //   this.tag=course.courseCode;
  //   this.name=course.name;
  //   this.preReqs=preReqs;
  //   this.x = 0;
  //   this.y = 0;
  //   this.dnWidth = 100;
  //   this.dnHeight = 100;
  //   //this.x = 110*(test%9);
  //   //this.y = 110*(test/9);
  // }
  
  DataNode(Course course, int id) {
    this.ID = id;
    this.tag=course.courseCode;
    this.name=course.name;
    this.preReqs= course.preReqs; 
    this.coReqs = course.coReqs;//TODO add coReqs
    this.x = 0;
    this.y = 0;
    this.dnWidth = 100;
    this.dnHeight = 100;
    
  }

  //find parents ID from tag
  void getParents() {
    parentIDs = new int[preReqs.length];
    int counter =0;
    for (int j=0; j < courseTiles.length; j++) {
      if (isParent(courseTiles[j])) {
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
    for (int i=0; (i < parentIDs.length); i++) {
      line(x+50, y, courseTiles[parentIDs[i]].x+50, courseTiles[parentIDs[i]].y+100);
    }
  }
  
  void drawNode(float x,float y,float w,float h) {
    //TODO actually do this lol;
    fill(x%255, y%255, x%255);
    rect(x, y, w, h);
    
    
    // //rect
    // fill(colour);
    // rect(x, y, 100, 100);
    // placeText(""+ID, x, y, 20, 20);//ID
    // placeText(tag, x+22, y, 70, 20);//Tag
    // placeText(name, x, y+22, 98, 75);//Title

    // //Lines
    // for (int i=0; i < parentIDs.length; i++) {
    //   line(x+50, y, courseTiles[parentIDs[i]].x+50, courseTiles[parentIDs[i]].y+100);
    // }
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

  void showDescriptiom(int inMouseX, int inMouseY) {
    if (isIn(inMouseX, inMouseY)) {
      drawDesc(inMouseX, inMouseY);
    }
  }

  boolean isIn(int inMouseX, int inMouseY) {
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

    println(width, descWidth);

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
    for (int i = 0; i<preReqs.length; ++i) {
      Pre += preReqs[i]+" ";
    }
    text(description+"\n\n"+Pre, inMouseX+hMargin, inMouseY+hTextSize*line+hMargin*line, descWidth, descHeight);
  }
}
