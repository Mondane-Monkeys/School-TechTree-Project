public void draw(float x, float y, float width, float height) {
    //To get any given course, you can use courseTiles[i]
    //to draw course tile, use courseTiles[i].drawNode(x,y,height,width). It should work just like a rect()
    
    //if (filter!= null) {
    //    subCourseTiles = searchResults;
    //}
    
     //Example
     fill(80,160,200);
     rect(x, y, width, height);
    
     int cols = 3;
    
    float tileWidth = width / cols; //calculate tile size
    float tileHeight = tileWidth;
    
    for (int i = 0; i < courseTiles.length; ++i) {
        if (courseTiles[i]!= null) {
            float posX = x + ((i % cols) * tileWidth); //Calculate tile position
            float posY = y + (i / cols) * tileHeight; 
            courseTiles[i].drawNode(posX, posY, tileWidth, tileHeight);
        }
    } //doesn't handle overflow
}


private DataNode[] searchResults(String filter) {
    ArrayList<DataNode> returnList = new ArrayList<DataNode>();
    
    //filtered list
    for (DataNode course : courseTiles) {
        if (course.tag.contains(filter) || course.name.contains(filter)) {
            returnList.add(course);
        }
    }
    
    return returnList;
}
