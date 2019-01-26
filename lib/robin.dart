import 'package:flutter/material.dart';

class Robin extends StatefulWidget {
  @override
  _RobinState createState() => _RobinState();
}

class _RobinState extends State<Robin> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  get height => 48;

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
        appBar: AppBar(
          title: Text("User Name"),
        ),
        body: Center(
            child: Text("User data will go here: ")
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), title: Text('Chart')),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), title: Text('Donate')),
            BottomNavigationBarItem(
                icon: Icon(Icons.map), title: Text("Distribution"))
          ],
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.attach_money)
      ),


    );
  }


