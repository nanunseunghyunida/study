void main() {
  runSample9();
}

//////////////////////////////////////////////////////////
// 1. Class
// Class 내부에선 타입 명시 (함수 내부에선 var로 선언)
class Player {
  final String name = 'shjeong';
  int xp = 1500;

  void sayHello() {
    print("Hi my name is $name");
  }
}

void runSample1() {
  // 객체 생성 시 [new] 생략 가능
  var player = Player();
  player.sayHello();
}

//////////////////////////////////////////////////////////
// 2. Constructor
class Player2 {
  // late final String name;
  // late int xp;
  final String name;
  int xp;

  // Player2(String name, int xp) {
  //   this.name = name;
  //   this.xp = xp;
  // }
  Player2(this.name, this.xp);

  void sayHello() {
    print("Hi my name is $name");
  }
}

void runSample2() {
  var player = Player2("shjeong2", 1400);
  player.sayHello();
}

//////////////////////////////////////////////////////////
// 3. Named Constructor Parameters
class Player3 {
  final String name;
  int xp;
  String team;
  int age;

  Player3({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  });

  void sayHello() {
    print("Hi my name is $name, my team is $team");
  }
}

void runSample3() {
  var player = Player3(
    name: "shjeong3",
    xp: 1600,
    team: "blue",
    age: 22,
  );
  player.sayHello();
}

//////////////////////////////////////////////////////////
// 4. Named Constructors
// 취향에 맞는 생성자 추가 가능
class Player4 {
  final String name;
  int xp;
  String team;
  int age;

  Player4({
    required this.name,
    required this.xp,
    required this.team,
    required this.age,
  });

  // Named parameter
  Player4.createRedPlayer({
    required String name,
    required int age,
  })  : this.age = age,
        this.name = name,
        this.team = "red",
        this.xp = 0;

  // Positional parameter
  Player4.createBluePlayer(String name, int age)
      : this.age = age,
        this.name = name,
        this.team = "blue",
        this.xp = 0;

  void sayHello() {
    print("Hi my name is $name, my team is $team");
  }
}

void runSample4() {
  var redPlayer = Player4.createRedPlayer(
    name: "shjeong4",
    age: 30,
  );
  redPlayer.sayHello();

  var bluePlayer = Player4.createBluePlayer("shjeong4", 29);
  bluePlayer.sayHello();
}

//////////////////////////////////////////////////////////
// 5. Cascade Notation
//[..] 연산자 앞에 있는 객체에 dot을 찍는거와 같은 문법
class Player5 {
  String name;
  int xp;
  String team;

  Player5({
    required this.name,
    required this.xp,
    required this.team,
  });

  void sayHello() {
    print("Hi my name is $name");
  }
}

void runSample5() {
  var player = Player5(name: 'shjeong5', xp: 1200, team: "red")
    // player.name = "asdd";
    // player.xp = 120000;
    // player.team = "red"
    ..name = 'asdad'
    ..xp = 120000
    ..team = "blue"
    ..sayHello();
  // player
  //   ..name = 'asdqq'
  //   ..team = "blue"
  //   ..xp = 52000;
}

//////////////////////////////////////////////////////////
// 6. Enum
// 관련이 있는 상수들의 집합체
enum Team { red, blue }

class Player6 {
  String name;
  int xp;
  Team team;

  Player6({
    required this.name,
    required this.xp,
    required this.team,
  });

  void sayHello() {
    print("Hi my name is $name, my team is ${team.name}");
  }
}

void runSample6() {
  var player = Player6(name: "shjeong", xp: 15000, team: Team.red);
  player.sayHello();
}

//////////////////////////////////////////////////////////
// 7. Abstract Class
// 추상클래스로 상속받는 클래스에 blueprint 제공
abstract class Human {
  void walk();
}

class Player7 extends Human {
  String name;
  int xp;
  Team team;

  Player7({
    required this.name,
    required this.xp,
    required this.team,
  });

  @override
  void walk() {
    print("$name is walking");
  }
}

void runSample7() {
  var player = Player7(name: "shjeong", xp: 13000, team: Team.blue)..walk();
}

//////////////////////////////////////////////////////////
// 8. Inheritance
// 그냥 기존에 많이 보이던 상속
class Human2 {
  final String name;

  Human2({
    required this.name,
  });

  void sayHello() {
    print("Hi my name is $name");
  }
}

class Player8 extends Human2 {
  final Team team;

  Player8({
    required this.team,
    required String name,
  }) : super(name: name);

  void sayHello() {
    super.sayHello();
    print("and i play in ${team.name}");
  }
}

void runSample8() {
  var player = Player8(team: Team.red, name: "shjeong");
  player.sayHello();
}

//////////////////////////////////////////////////////////
// 9. Mixin
// 생성자가 없는 클래스
// 클래스에 프로퍼티들을 추가하거나 할 때 사용
class Strong {
  final double str = 1500.99;
}

class QuickRunner {
  void runQuick() {
    print("ruuuuuuuuuun!");
  }
}

class Tall {
  final double height = 1.99;
}

class Player9 with Strong, QuickRunner, Tall {}

class Horse with Strong, QuickRunner, Tall {}

class Kid with QuickRunner {}

void runSample9() {
  var player = Player9();
  player.runQuick();
}
