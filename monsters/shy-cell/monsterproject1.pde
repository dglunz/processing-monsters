//**
// R. S. Wennerdahl
// February 2009
 
void setup() 
{
  size(300, 400); 
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
}

    float xoff = 0.0;
    float yoff = 0.0;
    float zoff = 0.0;
    
    float c1 = 255;
        float c2 = 0;
        
    float ns1 = 49;
    float ns2 = 50;
        
       
  
void draw() 
{   
  
  background(255);
  
  translate(width/10, height/10);
  
  
  
   // launch spikes
  
  if(keyPressed) 
{
if (key == '1') 
{
c1 = 0;
c2 = 255;
ns1 = 9;
ns2 = 10;
xoff = xoff + 0.035;
  yoff = yoff + 0.033;
  zoff = zoff + 0.031;
    }
  } else 
  {
    c1 = 255;
    c2 = 0;
    ns1 = 49;
    ns2 = 50;
    xoff = xoff + 0.005;
  yoff = yoff + 0.003;
  zoff = zoff + 0.001;
  }
  
   // end spikes
   
  
  
  
 // invisibilty
  
    if(keyPressed) 
{
if (key == '2') 
{
c1 = 255;
c2 = 255;
    }
  } else 
  {
    c1 = 255;
    c2 = 0;

  }
  
   // end invisibilty
  
 
   
   // the lower the value after the + the slower the changes
  xoff = xoff + 0.005;
  yoff = yoff + 0.003;
  zoff = zoff + 0.001;
  
     smooth (); 
  
    float n = noise(xoff) * width;
    float a = noise(yoff) * width;
    float v = noise(zoff) * width;
  
  
  // begin body

fill(c2);
ellipse(n, a, 100, 100);

fill(c1);
ellipse(n, a, 95, 95);
    
 // end body
 
 
 
 
   // begin nucleus
   

fill(c2);
ellipse(n + 15, a + 10, ns2, ns2);

fill(c1);
ellipse(n + 15, a + 10, ns1-5, ns1-5);
    
 // end nucleus
 

 
 // begin spikes
 
  fill(c2);
 stroke(c1);

// south 
line(n + 0, a + 50, n + 0 , a + 100);

// north
line(n + 0, a - 50, n + 0 , a - 100);

// east
line(n + 50, a, n + 100 , a);

// west
line(n - 50, a, n - 100 , a);

 
 // end spikes
 
 
 
 // begin little circle parts
 
  
   fill(c2);
ellipse(n + 0, a + 50, 10, 10);

 fill(c2);
ellipse(n + 0, a - 50, 10, 10);

ellipse(n + 50, a, 10, 10);

 fill(c2);
ellipse(n - 50, a, 10, 10);

// little circle parts



        
}

