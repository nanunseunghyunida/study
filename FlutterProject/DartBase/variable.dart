void main() {
  print("hello world");

  // 1. Var
  // var는 함수 내부에서 지역변수 선언 시 사용
  var name1 = "shjeong";
  // var는 선언 시 타입으로 고정
  // name = 123; // type missmatch error

  // 2. Dynamic
  // var로 변수 선언과 함께 초기화 해주지 않는 경우에 타입이 dynamic으로 지정됨 (or dynamic으로 선언 가능)
  var name2;
  name2 = "shjeong";
  name2 = 123;
  name2 = true; // 변수 타입 변경 가능

  // dynamic으로 선언된 변수는 compile 단계에서 변수의 타입이 뭔지 확인할 수 없음
  // is keyword를 사용하여 타입 유추 후 해당 타입에 맞는 함수 사용 가능
  if (name2 is String) {
    name2.split("1");
  }
  if (name2 is int) {
    name2.isEven;
  }

  // 3. Nullable
  // 기본적으로 변수들은 null 값이 허용되지 않음
  // type 뒤에 ?를 붙여 nullable로 선언 가능
  // String name3 = "shjeong";
  String? name3 = "shjeong";
  name3 = null;
  // Nullable 변수에 ?를 붙여야지만 다른 메소드가 사용 가능
  // name3.contains("d");
  name3?.contains("d");
  // 위와 동일
  if (name3 != null) {
    name3.contains("d");
  }

  // 4. Final
  // final로 선언된 변수는 이후 값 변경 불가능
  final name4 = "shjeong";
  // name4 = "shj"; // 변경 불가능

  // 5. Late
  // 변수 선언 후 값 할당을 나중에 할 수 있음
  // 값 할당 이전에 사용 시 Dart에서 check해서 컴파일 에러가 발생함
  late final String name5;
  // print(name5); // 컴파일 에러 발생
  name5 = "shjeong";
  print(name5);

  // 6. Const
  // JS의 const와 다름
  // 기본적으로 final과 같으나, compile time에 값이 정해져야됨 (추후 할당 불가능)
  const apiKey = "123123";
  // const String apiKey = getApiKey(); // Runtime중 할당 불가능
}
