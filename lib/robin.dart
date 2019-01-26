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
        child: ListView(
          children: list
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outlined, color: Colors.blue[500]), title: Text('Chart')),
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
  List<Widget> list = <Widget>[
    ListTile(
      title: Text("Data Set 1"),
      leading: Icon(
        Icons.group),
    ),
    ListTile(
        title: Text("Data Set 2"),
        leading: Icon(
          Icons.place),
  ),
    ListTile(
        title: Text("Data Set 3"),
        leading: Icon(
          Icons.history),
  ),
    ListTile(
        title: Text("Data Set 4"),
        leading: Icon(
          Icons.show_chart),
  ),
];
