public void draw(float x, float y, float width, float height){
    //To get any given course, you can use courseTiles[i]
    //to drawa course tile, use courseTiles[i].drawNode(x,y,height,width). It should work just like a rect()
    
    //Example
    fill(80,160,200);
    rect(x, y, width, height);
    
    int cols = 3;
    float tileWidth = width/cols;
    float tileHeight =tileWidth;
    
    for (int i = 0; i < courseTiles.length; ++i) {
        if (courseTiles[i]!=null) {
            float posX = x+((i%cols)*tileWidth);
            float posY = y+(i/cols)*tileHeight;
            courseTiles[i].drawNode(posX, posY, tileWidth, tileHeight);
        }
    } //doesn't handle overflow
}
