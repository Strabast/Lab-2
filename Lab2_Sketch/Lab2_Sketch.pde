PVector[] pos;
PVector[] acc;
PVector fol;
PVector mid;

int num = 50;
int speed = 5;
int colour = 0;

void setup() {
  size(700, 700);

  pos = new PVector[num];
  acc = new PVector[num];
  fol = new PVector(0, 0, 0);
  mid = new PVector(width/2, height/2, 0);

  //populate
  for (int i = 0; i < num; i++) {
    pos[i] = new PVector(random(width), random(height), random(30, 40));
    acc[i] = new PVector(random(-speed, speed), random(-speed, speed), 0);
  }
}

void draw() {
  background(0);

  //ball that follows mouse
  fol.lerp(mouseX, mouseY, 0.0, 0.1);
  ellipse(fol.x, fol.y, 50, 50);

  for (int j = 0; j < num; j++) {
    float d = PVector.dist(fol, mid);
    pos[j].add(acc[j]);
    ellipse(pos[j].x, pos[j].y, pos[j].z, pos[j].z);
    rect(width/2, height/2, 50, 50);

    //after border has been hit enough times, balls change colour
    if (pos[j].x > width - (pos[j].z/2)||pos[j].x < (pos[j].z/2)) {
      acc[j].x = acc[j].x * -1;
      colour++;
      if (colour > 250) {
        fill(random(255), random(255), random(255));
        colour = 0;
      }
    }

    if (pos[j].y > height - (pos[j].z/2)||pos[j].y < (pos[j].z/2)) {
      acc[j].y = acc[j].y * -1;
      if (colour > 250) {
        fill(random(255), random(255), random(255));
        colour = 0;
      }
    }

    //when following ball is in the square, all other balls gather to bottom right
    if (d <= 50) {
      acc[j].x = acc[j].x * random(0.01, -0.01);
      acc[j].y = acc[j].y * random(0.01, -0.01);

      if (acc[j].x < 1 && acc[j].y < 1) {
        acc[j].x = random(3, -3);
        if (pos[j].x > width - (pos[j].z/2)||pos[j].x < (pos[j].z/2)) {
          acc[j].x = acc[j].x * -1;
        }
        acc[j].y = random(3, -3);
        if (pos[j].y > height - (pos[j].z/2)||pos[j].y < (pos[j].z/2)) {
          acc[j].y = acc[j].y * -1;
        }
      }
    }
  }
}
//reset
void mousePressed() {
  for (int i = 0; i < num; i++) {
    pos[i] = new PVector(random(width), random(height), random(30, 40));
    acc[i] = new PVector(random(-speed, speed), random(-speed, speed), 0);
  }
}
