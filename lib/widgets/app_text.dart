  import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppText({required this.text, this.color = Colors.black54, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize:size ,color: color));
  }
}
