import 'package:flutter/material.dart';

class BuildContextSample extends StatefulWidget {
  const BuildContextSample({super.key});

  @override
  State<BuildContextSample> createState() => _AppState();
}

class _AppState extends State<BuildContextSample> {
  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle
                  ? const MyLargeTitle()
                  : const Text(
                      'Nothing',
                      style: TextStyle(
                        // Context를 사용하여 상위 트리의 테마에 접근
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              IconButton(
                onPressed: toggleTitle,
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 50,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  // build 메소드 이전에 호출되어야 한다
  // 단 한번만 실행할 수 있다
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  // 위젯이 화면에서 제거될 때 호출되는 메소드
  // API update, 이벤트 리스너로 부터 구독을 취소할 수 있음
  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  // BuildContext는 위젯 트리에서 위젯의 위치를 제공함
  @override
  Widget build(BuildContext context) {
    print('build');
    return Text(
      'My Large Title',
      style: TextStyle(
        // Context를 사용하여 상위 트리의 테마에 접근
        color: Theme.of(context).textTheme.titleLarge?.color,
        fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
        fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight,
      ),
    );
  }
}
