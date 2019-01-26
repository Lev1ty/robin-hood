import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FlutterLogo(),
              ),
              Expanded(
                child: Text(
                  'Robin',
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    ScopedModel.of<AppModel>(context).login();
                    Navigator.pushNamed(context, 'splash');
                  },
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
