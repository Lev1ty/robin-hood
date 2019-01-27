import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:charts_flutter/flutter.dart';

import 'splash.dart';
import 'model.dart';
import 'login.dart';
import 'robin.dart';
import 'the_people.dart';
import 'camera.dart';

void main() => runApp(
      ScopedModel(
        model: AppModel(),
        child: App(),
      ),
    );

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robin',
      home: Login(),
      routes: {
        'splash': (context) => Splash(),
        'the_people': (context) => ThePeople(),
        'robin': (context) => Robin(),
        'camera': (context) => Camera(),
      },
    );
  }
}
