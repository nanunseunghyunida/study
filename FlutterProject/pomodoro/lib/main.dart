import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(const Pomodoro());
}

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color(0xFF232B55),
            ),
          ),
          cardColor: const Color(0xFFF4EDDB),
          colorScheme:
              ColorScheme.fromSwatch(backgroundColor: const Color(0xFFE7626C)),
        ),
        home: const HomeScreen());
  }
}
