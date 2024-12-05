void main() {
//   Fish().move();
//   Bird().move();
//   Animal().move();
  // Duck().fly();
  // Duck().swim();
  Airplane().fly();
}

mixin CanSwim {
  void swim() {
    print('changing position by swimming');
  }
}

mixin CanFly {
  void fly() {
    print('changing position by flying');
  }
}

class Animal {
  void move() {
    print('changed position');
  }
}

class Fish extends Animal {
  @override
  void move() {
    super.move();
    print('by swimming');
  }
}

class Bird extends Animal {
  @override
  void move() {
    super.move();
    print('by flying');
  }
}

class Duck with CanSwim, CanFly {}

class Airplane with CanFly {}
