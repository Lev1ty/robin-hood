import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
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
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Robin'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () => Navigator.pushNamed(context, 'the_people'),
                  child: Text('The People'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
