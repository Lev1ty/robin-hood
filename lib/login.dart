import 'package:flutter/material.dart';

import 'model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 36),
          children: <Widget>[
            SizedBox(
              height: 36,
            ),
            Column(
              children: <Widget>[
                FlutterLogo(),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Robin',
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: Text('Cancel'),
                ),
                RaisedButton(
                  onPressed: () async => await AppModel.of(context).login(
                          _usernameController.text, _passwordController.text)
                      ? print('login success')
                      : print('login fail'),
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
