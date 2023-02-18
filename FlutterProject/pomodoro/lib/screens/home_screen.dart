import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const focusTime = 1500;
  static const breakTime = 300;
  static const goal = 4;

  int runningTime = focusTime;
  bool isRunning = false;
  bool isFocusTime = true;
  bool isComplete = false;
  int round = 1;

  late Timer timer;

  void onTick(Timer timer) {
    // Timer 만료
    if (runningTime == 0) {
      // 집중시간 만료 -> 휴식시간으로 전환
      if (isFocusTime) {
        setState(() {
          runningTime = breakTime;
          isFocusTime = false;
        });
        // 휴식시간 만료 -> 집중시간으로 전환
      } else {
        setState(() {
          runningTime = focusTime;
          isFocusTime = true;
        });
        onPausePressed();

        // 목표한 골에 도달
        if (round == goal) {
          setState(() {
            round = 1;
            isComplete = true;
          });
          // 라운드 + 1 -> 집중시간부터 다시 시작
        } else {
          setState(() {
            round++;
            isComplete = false;
          });
        }
      }
      // Timer 계속 돌리기
    } else {
      setState(() {
        runningTime--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);

    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();

    setState(() {
      runningTime = focusTime;
      isRunning = false;
      isFocusTime = true;
      isComplete = false;
      round = 1;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFocusTime
          ? Theme.of(context).colorScheme.background
          : Theme.of(context).textTheme.displayLarge!.color,
      body: Column(
        children: [
          // Flexible: flex 값을 통해 비율로 사이즈를 결정할 수 있는 위젯
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(runningTime),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                onPressed: isComplete
                    ? onResetPressed
                    : isRunning
                        ? onPausePressed
                        : onStartPressed,
                icon: Icon(isComplete
                    ? Icons.settings_backup_restore_outlined
                    : isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outlined),
                iconSize: 150,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                // 자식 위젯의 사이즈를 확장함
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isComplete ? 'Today Goal' : 'ROUND',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isComplete
                            ? Text(
                                '🎉Complete🎉',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$round ',
                                    style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                    ),
                                  ),
                                  Text(
                                    "/$goal",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color!
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
