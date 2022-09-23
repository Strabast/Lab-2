PVector[] pos;
PVector[] acc;
PVector fol;
PVector mid;

int num = 30;
int speed = 5;
int colour = 0;

void setup() {
  size(700, 700);

  pos = new PVector[num];
  acc = new PVector[num];
  fol = new PVector(width/2, height/2, 0);
  mid = new PVector(width/2, height/2, 0);

  //populate
  for (int i = 0; i < num; i++) {
    pos[i] = new PVector(random(width), random(height), random(30, 40));
    acc[i] = new PVector(random(-speed, speed), random(-speed, speed), 0);
  }
}

void draw() {
  background(0);

  fol.lerp(mouseX, mouseY, 0.0, 0.1);
  ellipse(fol.x, fol.y, 50, 50);
  
  for (int j = 0; j < num; j++) {
    float d = PVector.dist(fol, mid);
    pos[j].add(acc[j]);
    ellipse(pos[j].x, pos[j].y, pos[j].z, pos[j].z);

    if (pos[j].x > width - (pos[j].z/2)||pos[j].x < (pos[j].z/2)) {
      acc[j].x = acc[j].x * -1;
      colour++;
      if (colour > 50) {
        fill(random(255), random(255), random(255));
        colour = 0;
      }
    }

    if (pos[j].y > height - (pos[j].z/2)||pos[j].y < (pos[j].z/2)) {
      acc[j].y = acc[j].y * -1;
      if (colour > 50) {
        fill(random(255), random(255), random(255));
        colour = 0;
      }
    }

    if (d <= 0.5) {
      println("hello");
      acc[j].x = acc[j].x/5;
      acc[j].y = acc[j].y/5;
    }
  }
}

void mousePressed() {
  for (int i = 0; i < num; i++) {
    pos[i] = new PVector(random(width), random(height), random(30, 40));
    acc[i] = new PVector(random(-speed, speed), random(-speed, speed), 0);
  }
}
