import 'package:flutter/material.dart';

class ThePeople extends StatefulWidget {
  @override
  _ThePeopleState createState() => _ThePeopleState();
}

class _ThePeopleState extends State<ThePeople> with SingleTickerProviderStateMixin {
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
    return Container();
  }
}
