import 'package:flutter/material.dart';
import 'package:numkeyboard/views/custom_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Keyboard Sample',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const CustomKeyboard(),
    );
  }
}
