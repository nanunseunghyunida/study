void main() {
  print(sayHello("shjeong"));
  print(plus(1, 2.5));
  print(sayHello2(
    age: 20,
    name: "shjeong",
    country: "korea",
  ));
  print(sayHello2(name: "Park", country: "wakanda"));
  print(sayHello3("Kim", 13));
  print(capitalizeName("shjeong"));
}

// 1. Defining Function
// fat arrow syntax(=>) 를 사용하면 return 생략 가능
String sayHello(String name) => "Hello $name nice to meet you";
num plus(num a, num b) => a + b;

// 2. Named Arguments
// 함수 호출 시 인자의 위치를 기억해서 전달하는 방식이 아닌, 이름을 지정하여 전달하는 방식.
// 값이 들어오지 않을때를 위해 default value 지정 가능
// 값이 필수로 들어와야될 경우 required 사용하여 parameter 명시
String sayHello2({
  String name = "default",
  int age = 99,
  required String country,
}) =>
    "Hello $name, you are $age, and you come from $country";

// 3. Optional Positional Arguments
// Positional Arguments에서도 생략 가능하도록 선언할 수 있음 (잘 안씀)
String sayHello3(String name, int age, [String? country = "korea"]) =>
    "Hello $name, you are $age, and you come from $country";

// 4. QQ Operator
// name != null ? name.toUppercase() : "unknown";
// -> name?.toUppercase() ?? "unknown";
// [left ?? right] => left 값이 null이면 right 값 전달
// [left ??= right] => left 값이 null이면 left에 right 할당
String capitalizeName(String? name) => name?.toUpperCase() ?? "unknown";
