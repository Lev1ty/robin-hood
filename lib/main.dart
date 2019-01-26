import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'choice.dart';
import 'model.dart';
import 'login.dart';

void main() => runApp(
      ScopedModel(
        model: AppModel(),
        child: App(),
      ),
    );

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robin',
      home: Login(),
      routes: {
        'choice': (context) => Choice(),
      },
    );
  }
}
