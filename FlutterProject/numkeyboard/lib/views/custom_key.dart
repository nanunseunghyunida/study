import 'package:flutter/material.dart';

class CustomKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;
  final ValueSetter<dynamic> onLongPress;

  const CustomKey({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<CustomKey> createState() => _CustomKeyState();
}

class _CustomKeyState extends State<CustomKey> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      onLongPress: () {
        widget.onLongPress(widget.value);
      },
      child: AspectRatio(
        aspectRatio: 2, // 넓이 / 높이 = 2
        child: Center(
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
