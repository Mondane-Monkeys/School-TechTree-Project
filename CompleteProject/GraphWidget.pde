void drawGraphWidget(float x,float y,float width,float height){
    for (int i = 0; i < courseTiles.length; i++) { //DrawNodes
        if (courseTiles[i]!= null) {
            courseTiles[i].drawNode();
        }
    }
    
    updateActive(); //Set mousePos variable
    
    if (highlighting) { //Update highlighting
        fill(100, 100, 100, 50);
        rect(mousePos[0], mousePos[1], mouseX - mousePos[0], mouseY - mousePos[1]);
    }
    
    mousePos[4] = mousePos[2]; //Change mouse positions
    mousePos[5] = mousePos[3];
    mousePos[2] = mouseX;
    mousePos[3] = mouseY;
    
    // for (int i=0; i < courseTiles.length; i++) { //Move multiSelect
    // if (multiSelect[i]&&mousePressed&&mouseButton==LEFT) {
    // println("CompleteProject.draw: " + (i));
    // courseTiles[i].x += mousePos[2]-mousePos[4];
    // courseTiles[i].y += mousePos[3]-mousePos[5];
    //  }
// }
}


void generateGraph(){
    //Rules: minimizeEdgeLength, No overlap
    
    //TEMP generate positions array from current Nodes
    float[][] positions = new float[courseTiles.length][2];
    for (int i = 0; i < courseTiles.length; ++i) {
        positions[i][0] = courseTiles[i].x;
        positions[i][1] = courseTiles[i].y;
    }
    println(edgeLength(positions));
}

void badOptimize(){
    for (int i = 0; i < courseTiles.length; ++i) {
        courseTiles[i].y = floor(courseTiles[i].y);
        courseTiles[i].x = floor(courseTiles[i].x);
    }
    
    
    float currentDist = edgeLength(currentPositionArray());
    float previousDist = currentDist;
    for (int i = 0; i < courseTiles.length; ++i) {
        courseTiles[i].x+=1;
        currentDist = edgeLength(currentPositionArray());
        while (currentDist<previousDist) {
            previousDist = currentDist;
            courseTiles[i].x+=1;
            courseTiles[i].x=Math.max(0, courseTiles[i].x);
            courseTiles[i].x=Math.min(width-150, courseTiles[i].x);
            currentDist = edgeLength(currentPositionArray());
        }
        
        courseTiles[i].y+=1;
        previousDist = currentDist;
        currentDist = edgeLength(currentPositionArray());
        while (currentDist<previousDist) {
            previousDist = currentDist;
            courseTiles[i].y+=1;
            courseTiles[i].y=Math.max(0, courseTiles[i].y);
            courseTiles[i].y=Math.min(height-150, courseTiles[i].y);
            currentDist = edgeLength(currentPositionArray());
        }
        
        courseTiles[i].x-=2;
        previousDist = currentDist;
        currentDist = edgeLength(currentPositionArray());
        while (currentDist<previousDist) {
            previousDist = currentDist;
            courseTiles[i].x+=1;
            courseTiles[i].x=Math.max(0, courseTiles[i].x);
            courseTiles[i].x=Math.min(width-150, courseTiles[i].x);
            currentDist = edgeLength(currentPositionArray());
        }
        
        courseTiles[i].y-=2;
        previousDist = currentDist;
        currentDist = edgeLength(currentPositionArray());
        while (currentDist<previousDist) {
            previousDist = currentDist;
            courseTiles[i].y+=1;
            courseTiles[i].y=Math.max(0, courseTiles[i].y);
            courseTiles[i].y=Math.min(height-150, courseTiles[i].y);
            currentDist = edgeLength(currentPositionArray());
        }
    }
}

float[][] currentPositionArray(){
    float[][] positions = new float[courseTiles.length][2];
    for (int i = 0; i < courseTiles.length; ++i) {
        positions[i][0] = courseTiles[i].x;
        positions[i][1] = courseTiles[i].y;
    }
    return positions;
}

float edgeLength(float[][] positions){
    //should be float[#courses][2];//Ie, {{x,y}, {x,y}...}
    //for each, getDist(course[i], positions[i.parents]);
    float[] distances = new float[positions.length*positions.length];//Max number of edges = sqr(nodes);
    int edgeCount = 0;
    for (int i = 0; i < positions.length; ++i) {
        for (int j = 0; j < courseTiles[i].parentIDs.length; ++j) {
            if (courseTiles[i].parentIDs[j]>=0) {
                int parentID = courseTiles[i].parentIDs[j];
                fill(255, 0, 0);
                circle(positions[i][0],positions[i][1]+courseTiles[i].dnHeight,20);
                fill(0, 0, 255);
                circle(positions[parentID][0],positions[parentID][1],20);
                distances[edgeCount++] = dist(positions[i][0],positions[i][1], positions[parentID][0],positions[parentID][1]+courseTiles[i].dnHeight);//
            }
        }
    }
    
    for (int i = 1; i < edgeCount; ++i) {
        distances[0]+=distances[i];
    }
    return distances[0]+1000*overlap(positions);
}

float overlap(float[][] positions){
    float totalOverlap = 0;
    for (int i = 0; i < positions.length; ++i) {
        for (int j = 0; j < positions.length; ++j) {
            if (i!=j) {
                float xOverlap = Math.max(0, positions[i][0]-positions[j][0]+130);//calculate the X overlap, 100=width and height of tile, +30 for margins
                float yOverlap = Math.max(0, positions[i][1]-positions[j][1]+130);
                if (xOverlap<100 && yOverlap<100) {
                    totalOverlap += (xOverlap*yOverlap);
                }
            }
        }
    }
    return totalOverlap;
}