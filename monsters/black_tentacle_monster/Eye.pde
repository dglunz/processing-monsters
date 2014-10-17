class Eye
{
    float eyeSize;
    float pupilSize;
    float eyeDistance;
    float eyeX;
    float eyeY;
    float pupilX;
    float pupilY;
    
    Eye(float x, float y, float e)
    {
        eyeSize = 40;
        pupilSize = 15;
        eyeX = x;
        eyeY = y;
        eyeDistance = e;
        
        pupilX = eyeX;
        pupilY = eyeY;
    }
    
    void update()
    {
        float mY = map(mouseY, 0, height, -eyeSize/4, eyeSize/4);
        pupilY = eyeY + mY;

        float mX = map(mouseX, 0, height, -eyeSize/4, eyeSize/4);
        pupilX = eyeX + mX;
    }
    
    void draw()
    {
        // stroke around eyeball
        fill(0);
        ellipse(eyeX, eyeY, eyeSize + 4, eyeSize + 4);
        
        // eyeball
        fill(255);
        ellipse(eyeX, eyeY, eyeSize, eyeSize);
        
        // pupil
        fill(0);
        ellipse(pupilX, pupilY, pupilSize, pupilSize);    
    }
}
