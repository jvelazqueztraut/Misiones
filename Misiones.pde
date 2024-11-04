/*
EL ALETEO ERRANTE DE UNA MARIPOSA

Se cruzan de izquierda a derecha y vice-versa
Mientras más alto, más planean
Descienden todo el tiempo
Un aleteo las eleva según el airea desplazado
Aletear lleva un tiempo pero no siempre el mismo
Cuanto más bajo, más chances de aletear seguido

El ala es un plano de dos colores, dos texturas
Al planear se ve la parte de abajo finita
El aleteo comienza con un envión
Entonces se ve llena la parte de abajo
Y luego rápido la parte de arriba

La posición de las alas modifica su aceleración
Planeando logra rápido una velocidad terminal
Cada aleteo tiene una fuerza determinada
*/
final int N = 100;
Mariposa[] mariposas;
float time = 0;
color[] palette = {color(231,85,98), color(174,220,250), color(79,143,190), color(49,98,165), color(57,65,99)}; 
void setup(){
  //size(1000,200);
  fullScreen();
  mariposas = new Mariposa[N];
  for (int i = 0; i < N; i++) {
    int hAvg = (int)random(height);
    int hVar = (int)random(height*0.2, height);
    color c1 = palette[(int)random(palette.length)];
    color c2 = palette[(int)random(palette.length)];
    mariposas[i] = new Mariposa(random(0.4,1.),random(1.)>0.5,hAvg-hVar/2,hAvg+hVar/2,c1,c2);
  }
  time = millis()/1000.0;
}

void draw(){
  float t = millis()/1000.0;
  float dt = t - time;
  time = t;
  boolean getCount = (frameCount % 100) == 0;
  int count = 0;
  for(Mariposa m:mariposas){
    m.update(dt);
    if(getCount && m.x>0 && m.x<width && m.y>0 && m.y<height) count++;
  }
  if(getCount) println("Mariposas on screen:", count);
  background(100);
  for(Mariposa m:mariposas){
    m.draw();
  }
}

void keyPressed(){
  if(key == 's'){
    save("frame.jpg");
  }
}
