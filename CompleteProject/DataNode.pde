class DataNode {
  int ID;//position in main array
  String tag;//course ID like COMP1010
  String name; //course name like introducory computer Science
  String[] preReqs; //list of course prerequists by tag
  String[] coReqs;
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
    this.preReqs= (course.preReqs==null)? new String[0] : course.preReqs; 
    this.coReqs = (course.coReqs==null)? new String[0] : course.coReqs;//TODO add coReqs
    this.x = 0;
    this.y = 0;
    this.dnWidth = 100;
    this.dnHeight = 100;
    trimPreReqs();
  }
  
  void trimPreReqs(){
    //count prereqs
    int preReqCount = 0;
    for (preReqCount = 0; preReqCount < preReqs.length && preReqs[preReqCount]!=null; ++preReqCount) {
      //Do nothing lol
    }
    
    String[] newReqs = new String[preReqCount];
    
    for (int i = 0; i < newReqs.length; ++i) {
      newReqs[i]=preReqs[i];
    }
    
    preReqs = newReqs;
  }

  //find parents ID from tag
  void getParents() {
    parentIDs = new int[preReqs.length];
    for (int i = 0; i < parentIDs.length; ++i) {
      parentIDs[i] =-1;
    }
    int counter =0;
    int j; //itorator -> used to mark unfound preReqs as -1;
    for (j=0; j < courseTiles.length; j++) {
      if (isParent(courseTiles[j])) {
        parentIDs[counter++] = j;
      }
    }
  }

  boolean isParent(DataNode dn) {
    boolean returnVal = false;
    String parentTag = dn.tag;
    for (int i=0; i < preReqs.length && preReqs[i]!=null; i++) {
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
    strokeWeight(3);
    for (int i=0; (i < parentIDs.length); i++) {
      if (parentIDs[i]>=0) {
        line(x+50, y, courseTiles[parentIDs[i]].x+50, courseTiles[parentIDs[i]].y+100);
      }
    }
    strokeWeight(1);
    
    if (isIn(mouseX, mouseY)) {
      drawDesc(mouseX, mouseY);
    }
  }
  
  public void drawNode(float x,float y,float w,float h) { //ignores Node.x,y,w,h, and does not draw parentLines
    //rect
    placeText(""+ID, (int)x, (int)y, 0.2*w, 0.2*h);//ID
    placeText(tag, (int)x+0.22*w, (int)y, 0.78*w, 0.20*h);//Tag
    placeText(name, (int)x, (int)y+0.22*h, 0.98*w, 0.75*h);//Title
    
    if (isIn(mouseX, mouseY, x,y,w,h)) {
      drawDesc(mouseX, mouseY);
    }
  }
  
  void placeText(String s, float x, float y, float w, float h) {
    fill(colour2);
    rect(x, y, w, h);
    fill(255);
    stroke(255);
    textSize(Math.min(h*0.7, 15));
    text(s, x, y+h*0.15, w, h);
  }

  void showDescriptiom(int inMouseX, int inMouseY) {
    if (isIn(inMouseX, inMouseY)) {
      drawDesc(inMouseX, inMouseY);
    }
  }

  boolean isIn(int inMouseX, int inMouseY) {
    return inMouseX>x && inMouseX<(x+dnWidth) && inMouseY>y && inMouseY<(y+dnHeight);
  }
  
  boolean isIn(int inMouseX, int inMouseY, float x,float y,float w,float h) {
    return inMouseX>x && inMouseX<(x+w) && inMouseY>y && inMouseY<(y+h);
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
  
  public String toString(){
    return tag;
  }
}
