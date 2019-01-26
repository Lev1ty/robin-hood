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
              icon: Icon(Icons.show_chart, color: Colors.blue[500]), title: Text('Chart')),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money, color: Colors.transparent), title: Text(" ")),
          BottomNavigationBarItem(icon: Icon(Icons.map, color: Colors.blue[500]), title: Text("Distribution"))
        ],
      ),
      floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.attach_money),
            label: Text("Donate")

      )


    );
  }

}
