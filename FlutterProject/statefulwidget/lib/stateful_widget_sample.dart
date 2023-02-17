import 'package:flutter/material.dart';

class StatefulWidgetSample extends StatefulWidget {
  const StatefulWidgetSample({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

// State가 React때 처럼 엄청 비중있는 느낌은 아니라고함
// Widget 자체의 기능으로 interactive한 application을 만들 수 있음
class _AppState extends State<StatefulWidgetSample> {
  List<int> numbers = [];

  void onClicked() {
    // setState 호출 시 build method가 재실행 되면서 UI가 업데이트 됨
    setState(() {
      // 항상 setState안에서 값을 변경할 필요는 없음
      // 값은 별도로 변경 후 setState를 나중에 호출해 주는 방법을 사용해도 됨
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Click Count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  IconButton(
                    onPressed: onClicked,
                    icon: const Icon(
                      color: Colors.white,
                      size: 30,
                      Icons.add_box_rounded,
                    ),
                  ),
                ],
              ),
              // for문으로 UI 그리기가 쉽다
              for (var number in numbers)
                Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
