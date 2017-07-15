class Dot
{  
  public float currentX;
  public float currentY;
  float stepSize;
  float radius;
  float speed;
  color dotColor;
  
  float colorNoise = 0;
  float colorNoiseStep = .005;
  float colorNoiseOffset = 20;
    
  float colorValue1;
  float colorValue2;
  float colorValue3;
    
  
  Dot(float startX, float startY, float r, float s, color c) 
  {
    currentX = startX;
    currentY = startY;
    radius = r;
    speed = s;
    dotColor = c;
  }
  
  //Draws the circles
  void Update1()
  {
    float angle = atan2(currentY - mouseY, currentX - mouseX);
    
    currentX = currentX + cos(angle) * speed;
    currentY = currentY + sin(angle) * speed;
    
    if(currentX + radius > width || currentX - radius < 0 || 
        currentY + radius > height || currentY - radius < 0)  
    {
      currentX = random(0, width);
      currentY = random(0, height);
    }
    
    colorNoise += colorNoiseStep;
    colorValue1 = noise(colorNoise) * 255;
    colorValue2 = noise(colorNoise + colorNoiseOffset) * 127 + 128;
    colorValue3 = noise(colorNoise + 2 * colorNoiseOffset) * 255;
    
    dotColor = color(colorValue1, colorValue2, colorValue3, 16);
    
    stroke(0, 0, 0, 16);
    fill(dotColor);
    ellipse(currentX, currentY, radius, radius);
  }
}