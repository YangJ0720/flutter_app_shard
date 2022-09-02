import 'package:flutter/material.dart';

class Show extends StatelessWidget {
  final String title;

  const Show(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DateTime.now().toIso8601String())),
      body: Center(child: Text(title)),
    );
  }
}
