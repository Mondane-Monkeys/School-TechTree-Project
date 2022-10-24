//CONTAINS EXAMPLE CLASSES FOR DROPDOWN MENUES AND TEXTBOXES


ValueBlock selectedValue;
TextField textFieldFocus;
OperationNode opNodeMoving;
OperationNode opNodeConnecting;
ArrayList<TextField> textFields = new ArrayList<TextField>();
ArrayList<Dropdown> dropdowns = new ArrayList<Dropdown>();
ArrayList<OperationNode> operationList = new ArrayList<OperationNode>();

public void setupExpressionEditor(){
    new TextField("", 50, 50, 100, 20);
    new Dropdown(50,100,100,20);
    new OperationNode("Test1", 50, 150, 75, 75);
    new OperationNode("Test2", 50, 250, 75, 75);
}

public void drawExpressionEditor(float x,float y,float w,float h){
    fill(140, 140, 255);
    rect(0, 0, 330, height);
    
    for (TextField tf : textFields) {
        tf.draw();
    }
    for (Dropdown dd : dropdowns) {
        dd.draw();
    }
    for (OperationNode on : operationList) {
        on.draw();
    }
    //nameEditor
    //type dropdown
    //Set value
}

class TextField{
    float x;
    float y;
    float w;
    float h;
    String str;
    int cursorBlink = 0;
    int blinkLength = 80; //frames per blink 
    
    public TextField(String str, float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.str = str;
        textFields.add(this);
        textFieldFocus = this;
    }
    
    public String handleInput(char c){
        cursorBlink = 0;
        textSize(h*0.8);
        if (c == DELETE || c == BACKSPACE) {
            str = str.substring(0,str.length()-1);
        } else if (textWidth(str)<w-10 && c>=' ' && c<='~') {
            str+=c;
        }
        return str;
    }
    
    public void draw(){
        fill(200);
        rect(x, y, w, h);
        fill(0);
        textSize(h*0.8);
        text(str, x+3, y, w, h);
        
        strokeWeight(1);
        cursorBlink = (cursorBlink+1)%blinkLength;
        if (cursorBlink < blinkLength/2) {
            float lineX = Math.min(x+4+textWidth(str), x+w);
            line(lineX, y+2 , lineX, y+h-2);
        }
    }
}

public void keyPressed() {
    if (textFieldFocus!=null) {
        println(textFieldFocus.handleInput(key));
    }
}

enum ValueTypes{
    FORMULA, NUMBER, DIRECTION, 
}
class Dropdown {
    float x;
    float y;
    float w;
    float h;
    boolean open = false;
    boolean released = true;
    
    ValueTypes type;
    
    
    public Dropdown(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        type = ValueTypes.NUMBER;
        dropdowns.add(this);
    }
    
    public void draw(){
        if (released && mousePressed && mouseInClosed()) {
            open = !open;
            released = false;
        }
        
        if (!mousePressed) {
            released = true;
        }
        
        fill(200);
        rect(x, y, w, h);
        fill(0);
        textSize(h*0.8);
        text(""+type, x+3, y, w, h);
        
        if (open) {
            float tempY = y+h+2;
            for (ValueTypes t : ValueTypes.values()) {
                stroke(155);
                fill(200);
                rect(x, tempY, w, h);
                textSize(h*0.8);
                fill(0);
                text(""+t, x+3, tempY, w, h);
                if (mousePressed && mouseInOption(tempY)) {
                    type = t;
                    new OperationNode(""+t, 50,600, 75, 75);
                }
                tempY+=h;
                stroke(0);
            }
        }
        
        if (mousePressed && released) {
            open = false;
        }
    }
    
    private boolean mouseInClosed(){
        return mouseX>x && mouseX<x+w && mouseY >y && mouseY<y+h;
    }
    private boolean mouseInOption(float y){
        return mouseX>x && mouseX<x+w && mouseY >y && mouseY<y+h;
    }
}

class OperationNode{
    static final int bubbleSize = 10;
    
    int inputCount;
    OperationNode input1;//top
    OperationNode input2;//bottom
    OperationNode output;
    ValueTypes inputType;
    ValueTypes outputType;
    
    float x;
    float y;
    float w;
    float h;
    
    String str;
    Color c;
    
    public OperationNode(String str, float x, float y, float w, float h, Color c){
        this.str = str;
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.c = c;
        
        operationList.add(this);
    }
    
    public void draw(){
        if (mousePressed) {
            if (mouseButton == RIGHT) {
                opNodeMoving =null;
                opNodeConnecting = null;
            }
            if (mouseIsInCenter()) {
                opNodeMoving = this;
            } else if (mouseIsInTop() && opNodeConnecting!=null) {
                input1 = opNodeConnecting;
                opNodeConnecting.output = this;
                opNodeConnecting=null;
            } else if (mouseIsInBottom() && opNodeConnecting!=null) {
                input2 = opNodeConnecting;
                opNodeConnecting.output = this;
                opNodeConnecting=null;
            } else if (mouseIsInOutput()) {
                opNodeConnecting = this;
            }
        }
        if (opNodeMoving == this) {
            x = mouseX;
            y=mouseY;
        }
        
        fill(160, 160, 255);
        
        if (mouseIsInCenter()) {
            strokeWeight(5);
        }
        rect(x, y, w, h); //main body
        strokeWeight(1);
        fill(0);
        textSize(20);
        text(str, x+5, y, w-10, h);
        
        fill(255, 160, 160);
        if (mouseIsInTop() && opNodeConnecting!=null) {
            strokeWeight(5);
        }
        circle(x, y+h/3, h/3); //input1
        strokeWeight(1);
        if (mouseIsInBottom() && opNodeConnecting!=null) {
            strokeWeight(5);
        }
        circle(x, y+2*h/3, h/3); //input2
        strokeWeight(1);
        if (mouseIsInOutput()) {
            strokeWeight(5);
        }
        circle(x+w, y+h/2, h/3); //output
        strokeWeight(1);
        
        if (input1!=null) {//Connecting line to input1
            line(x, y+h/3, input1.x+input1.w, input1.y+input1.h/2);
        }
        if (input2!=null) {//Connecting line to input1
            line(x, y+2*h/3, input2.x+input2.w, input2.y+input2.h/2);
        }
        if (opNodeConnecting==this) {//Connecting line from output to mouse
            line(x+w, y+h/2, mouseX, mouseY);
        }
        
    }
    
    public boolean mouseIsInCenter(){
        return mouseX>x+bubbleSize && mouseX<x+w-bubbleSize && mouseY>y && mouseY<y+h;
    }
    
    public boolean mouseIsInTop(){
        return mouseX>x && mouseX<x+bubbleSize && mouseY>y && mouseY<y+h/2;
    }
    
    public boolean mouseIsInBottom(){
        return mouseX>x && mouseX<x+bubbleSize && mouseY>y+h/2 && mouseY<y+h;
    }
    
    public boolean mouseIsInOutput(){
        return mouseX>x+w-bubbleSize && mouseX<x+w && mouseY>y && mouseY<y+h;
    }
}


/*
    Expr:
        bool(inRange(pt)), IsLast(), 
        Compare numbers -> a<=>b
        connect bools -> a AND b
        
    Number
        distanceTo(pt), distanceBetween(pt, pt)
        count(enemies/allies/units)
        time(inFrames) <- maybe include variables later
        Operators -> a +-/* b
            max, min, sqrt, sin, cos, etc
        health(mine, unit)
    
    directions
        towards(pt, enemy, ally, mouse)
        coordinal(up(0) down(180) left(270) right(90))
        combination( between(x,y), opposite(x) )
    
    Position
        enemy(#) <- the n'th enemy
        ally(#)
        coordinate(x,y)
        mouse Pos
*/
