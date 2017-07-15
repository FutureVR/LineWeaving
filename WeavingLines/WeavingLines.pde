import controlP5.*;

int numberOfCircles = 10;
int newNumberOfCircles;
float dotRadius = 0;
float dotSpeed = 1;
color dotColor = color(50, 200, 0);

float centerX;
float centerY;

float noiseY = 0;
float noiseYStep = .2;
float noiseHeight = 15;
float noiseXRange = 20;
float noiseDetail = .01;
float distance;
float angle;

boolean clearScreen = false;
boolean paused = false;

ControlP5 cp5;
RadioButton radioButtons;

Dot[] dots = new Dot[numberOfCircles];

void setup()
{
  size(1600, 900);
  background(255);  
  
  cp5 = new ControlP5(this);
  
  centerX = width / 2;
  centerY = height / 2;
  
  //Setup the gui
  cp5.addButton("Clear")
    .setValue(0)
    .setPosition(10, 10)
    .setSize(200, 30);
    
  cp5.getController("Clear")
    .getCaptionLabel()
    .setSize(20);
    
  cp5.addButton("Create_New")
    .setValue(0)
    .setPosition(10, 50)
    .setSize(200, 30);
    
  cp5.getController("Create_New")
    .getCaptionLabel()
    .setSize(20);
    
  cp5.addButton("PAUSE")
    .setValue(0)
    .setPosition(width - 210, 20)
    .setSize(200, 30);
    
  cp5.getController("PAUSE")
    .getCaptionLabel()
    .setSize(20);
    
  cp5.addButton("Toggle_Lines")
    .setValue(0)
    .setPosition(10, 130)
    .setSize(200, 30);
    
  cp5.getController("Toggle_Lines")
    .getCaptionLabel()
    .setSize(20);
    
  cp5.addSlider("Vertex_Num")
    .setPosition(10, 90)
    //.setCaptionLabel("Number of Vertices")
    .setColorCaptionLabel(color(0,0,0))
    .setSize(200, 30)
    .setRange(2, 15)
    .setValue(4)
    .setDecimalPrecision(0)
    .setNumberOfTickMarks(14);
    
    
  numberOfCircles = (int)cp5.getController("Vertex_Num").getValue();
  InitializeDots();
  
  paused = false;
  clearScreen = false;
}


void draw()
{ 

  if (!paused)
    {
      if(clearScreen) background(255);
      
      DrawLines();
      DrawDots();
      
      newNumberOfCircles = (int)cp5.getController("Vertex_Num").getValue();
    }
}


public void Clear()
{
  background(255);  
}

public void Create_New()
{
  numberOfCircles = newNumberOfCircles;
  InitializeDots();  
}

public void PAUSE()
{
  paused = !paused;
}


public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
}

public void Toggle_Lines()
{
  clearScreen = !clearScreen;
}

void DrawLines()
{
  for(int i = 0; i < dots.length; i++) {
    for(int j = 0; j < dots.length; j++) {
      
      pushMatrix();
      distance = (-1) * dist(dots[i].currentX, dots[i].currentY, dots[j].currentX, dots[j].currentY); 
      
      translate(dots[i].currentX, dots[i].currentY);
      angle = atan2(dots[i].currentY - dots[j].currentY, dots[i].currentX - dots[j].currentX);
      rotate(angle);
      
      noiseY += noiseYStep;
      
      if (clearScreen)
      {
        Dot myDot = dots[i];
        stroke(myDot.colorValue1, myDot.colorValue2, myDot.colorValue3);
        //stroke(0, 0, 0, 255);
      }
      else
      {
        stroke(0, 0, 0, 16);
      }
      
      beginShape();
      for(int x = 0; x < (-1) * distance; x += 5)
      {
        float noiseX = map(x, 0, (-1) * distance, 0, noiseXRange);
        float y = (noise(noiseX, noiseY) - .5) * noiseHeight;
       
        vertex(-x, -y);  
      }
      endShape();
       
      popMatrix();
    }
  }
}


void InitializeDots()
{ 
  dots = new Dot[numberOfCircles];
  
  for(int i = 0; i < dots.length; i++)
  {
    dots[i] = new Dot(random(0, width), random(0, height), 
                        dotRadius, dotSpeed, dotColor);
  }    
}

void DrawDots()
{
  for(int i = 0; i < dots.length; i++)
  {
    dots[i].Update1();        
  }
}
