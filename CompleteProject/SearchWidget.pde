//CONTAINS EXAMPLE CLASSES FOR DROPDOWN MENUES AND TEXTBOXES

TextField textFieldFocus;
ArrayList<TextField> textFields = new ArrayList<TextField>();
// ValueBlock selectedValue;
// OperationNode opNodeMoving;
// OperationNode opNodeConnecting;
// ArrayList<Dropdown> dropdowns = new ArrayList<Dropdown>();
// ArrayList<OperationNode> operationList = new ArrayList<OperationNode>();


public void drawSearchWidget(float x, float y, float width, float height) {
    //To get any given course, you can use courseTiles[i]
    //to draw course tile, use courseTiles[i].drawNode(x,y,height,width). It should work just like a rect()
    
    //if (filter!= null) {
    //    subCourseTiles = searchResults;
//}
    ArrayList filteredResults = searchResults(textFieldFocus.str);
    
    
    
    int cols = 3;
    
    float tileWidth = width / cols; //calculate tile size
    float tileHeight = tileWidth;
    
    for (int i = filteredResults.size() - 1; i >= 0; --i) { //Draw from bottom to top -> avoid description-Tile overlap
        float posX = x + ((i % cols) * tileWidth); //Calculate tile position
        float posY = y + (i / cols) * tileHeight; 
        DataNode temp = (DataNode)(filteredResults.get(i));
        temp.drawNode(posX, posY, tileWidth, tileHeight);
    } //TODO -> implement Scrollbar
}

/*
Add all results containing the users search filter to the arraylist
*/
ArrayList<DataNode> searchResults(String filter) {
    ArrayList<DataNode> returnList = new ArrayList<DataNode>();
    
    //filtered list
    for (DataNode course : courseTiles) {
        if (course.tag.contains(filter) || course.name.contains(filter)) {
            returnList.add(course);
        }
    }
    
    return returnList;
}

class TextField{
    float x;
    float y;
    float w;
    float h;
    String str;
    int cursorBlink = 0;
    int blinkLength = 80; //frames per blink 
    
    public TextField(String str, float x, float y, float w, float h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.str = str;
        textFields.add(this);
        textFieldFocus = this;
    }
    
    public String handleInput(char c) {
        cursorBlink = 0;
        textSize(h * 0.8);
        if (c ==  DELETE || c == BACKSPACE) {
            str = str.substring(0,str.length() - 1);
        } else if (textWidth(str)<w - 10 && c>= ' ' && c<= '~') {
            str += c;
        }
        return str;
    }
    
    public void draw() {
        fill(200);
        rect(x, y, w, h);
        fill(0);
        textSize(h * 0.8);
        text(str, x + 3, y, w, h);
        
        strokeWeight(1);
        cursorBlink = (cursorBlink + 1) % blinkLength;
        if (cursorBlink < blinkLength / 2) {
            float lineX = Math.min(x + 4 + textWidth(str), x + w);
            line(lineX, y + 2 , lineX, y + h - 2);
        }
    }
}

public void setupExpressionEditor() {
    new TextField("", 50, 50, 100, 20);
}
