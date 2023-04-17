import 'package:flutter/material.dart';
import 'package:freezed_sample/model/person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  renderText(String title, String text) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final school1 = School(id: 3, name: 'middle');
    final group1 = Group(id: 2, name: 'eng', school: school1);
    final person1 = Person(id: 1, name: 'shjeong', age: 29, group: group1);

    final personNew = person1.copyWith(
      group: group1.copyWith(
        school: school1.copyWith(name: 'high'),
      ),
    );

    final personNew2 = person1.copyWith.group.school(name: 'elementary');

    final person2 = Person(id: 1, name: 'shjeong', age: 29, group: group1);
    // freezed는 immutable하기 때문에 setter 사용 불가능
    // person1.age = 82;

    final person3 = Person(
        id: person1.id, name: person1.name, age: 72, group: person1.group);
    final person4 = person1.copyWith(age: 73);

    person1.hello();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            renderText('person1.id', person1.id.toString()),
            renderText('person1.name', person1.name),
            renderText('person1.age', person1.age.toString()),
            renderText('person1.toString()', person1.toString()),
            // renderText('person1.toJson()', person1.toJson().toString()),
            renderText('person1 == person2', (person1 == person2).toString()),
            renderText('person1.nameLength', person1.nameLength.toString()),
            renderText('person4.toString()', person4.toString()),

            renderText('personNew.toString()', personNew.toString()),
            renderText('personNew2.toString()', personNew2.toString()),
          ],
        ),
      ),
    );
  }
}
