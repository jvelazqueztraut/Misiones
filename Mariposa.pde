final float gravedad = 50;
final float xVelMin = 40;
final float xVelMax = 100;
final float yVelMin = -30;
final float yVelMax = 50;
final float dAlas = 250; // desplazamiento de las alas
final float posAlasMin = -0.25;
final float posAlasMax = 1.0;
final float posAlasPlaneo = 0.4;
final float vAlasMin = 5;
final float vAlasMax = 25;
final float vAlasPrep = -10;
final float vAlasRec = -5;
final float wSize = 50;
final float hSize = 60;
final float alaRatio = 0.4;
final float alaOverlap = 0.45;
class Mariposa 
{
  float w, h; // dimensions
  float x,y; // position
  int hMin, hMax;
  float xVel, yVel; // velocidad
  boolean direction;
  float posAlas; // posición vertical de las alas
  float vAlas; // velocidad alas
  boolean aleteando; // condición de aleteo
  float fAleteo; // fuerza de aleteo
  color c1, c2; // colors
 
  int aleteoHeight; // altura de aleteo random
  
  Mariposa(float size, boolean side, int heightMin, int heightMax, color _color1, color _color2){
    w = size*wSize;
    h = size*hSize;
    y = heightMin + (heightMax-heightMin)/2;
    hMin = heightMin;
    hMax = heightMax;
    yVel = 0;
    
    flip(side); // initialize x variables
    
    posAlas = posAlasPlaneo;
    vAlas = 0.0;
        
    aleteoHeight = heightMax;
    
    c1 = _color1;
    c2 = _color2;
  }
  
  void update(float dt){
    updateAlas(dt);
    updatePos(dt);
  }
  
  void updateAlas(float dt){
    posAlas = constrain(posAlas - vAlas*dt,posAlasMin,posAlasMax);
    if(aleteando){
      if(vAlas < 0){
        if(posAlas >= posAlasMax){
          vAlas = lerp(vAlasMin,vAlasMax,fAleteo);
        }
      }
      else{
        if(posAlas <= posAlasMin){
          vAlas = vAlasRec;
          aleteando = false;
        }
      }
    }
    else{ //no hay aleteo
      if(vAlas < 0 && posAlas >= posAlasPlaneo){
        vAlas = 0;
        posAlas = posAlasPlaneo;
      }
      float fuerza = y/(float)aleteoHeight;
      float ajusteVel = map(yVel,0,yVelMax,0.0,0.25);
      float p = random(fuerza) - ajusteVel;
      boolean superRandom = random(1.)>0.99 ? true : false;
      if(p > 0.5 || superRandom) aleteo(fuerza);
    }
  }
 
  void aleteo(float fuerza){
    fAleteo = fuerza;
    aleteoHeight = (int)random(hMin + (hMax-hMin)/2,hMax);
    vAlas = vAlasPrep;
    aleteando = true;
  }
  
  void updatePos(float dt){
    float despegue = (vAlas>0)?fAleteo*dAlas:0.0;
    yVel += constrain((despegue - gravedad)*dt,yVelMin, yVelMax);

    x -= xVel*dt;
    y -= yVel*dt;
    
    if(isOutside())
      flip(random(1.)>0.5);
  }
  
  boolean isOutside(){
    return (x+w/2)<0 || (x-w/2)>width;
  }
  
  void flip(boolean side){
    if(side) {
     x = -w/2;
     xVel = -random(xVelMin, xVelMax);
    }
    else {
      x = width+w/2;
      xVel = random(xVelMin, xVelMax);
    }
    direction = side;
  }
 
  void draw() {
    pushMatrix();
    translate(x, y);
    if(!direction) scale(-1.0,1.0);
    pushStyle();
    noStroke();
    fill(c1);
    triangle(-w*alaOverlap/2,0,w*(0.5-alaOverlap/2),-h*posAlas,w/2,0);
    fill(c2);
    //triangle(-w/2,0,0,-h*posAlas,w/2,0);
    triangle(-w/2,0,w*(alaOverlap/2-0.5),-h*posAlas*alaRatio,w*alaOverlap/2,0);
    popStyle();
    popMatrix();
  }
}
