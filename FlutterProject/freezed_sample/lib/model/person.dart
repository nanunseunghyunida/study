import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
// part 'person.g.dart';

@freezed
class Person with _$Person {
  // @Assert('name.length < 10', '이름의 길이는 10보다 작아야합니다.')
  factory Person({
    required int id,
    required String name,
    required int age,
    required Group group,
    int? statusCode,
  }) = _Person;

  // factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  // getter나 custom method를 사용하려면 internal constructor를 선언해야됨
  Person._();

  get nameLength => name.length;
  void hello() {
    print('hello');
  }
}

@freezed
class Group with _$Group {
  // @Assert('name.length < 10', '이름의 길이는 10보다 작아야합니다.')
  factory Group({
    required int id,
    required String name,
    required School school,
  }) = _Group;
}

@freezed
class School with _$School {
  // @Assert('name.length < 10', '이름의 길이는 10보다 작아야합니다.')
  factory School({
    required int id,
    required String name,
  }) = _School;
}
