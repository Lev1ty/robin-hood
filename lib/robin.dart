import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';

class Robin extends StatefulWidget {
  @override
  _RobinState createState() => _RobinState();
}

class _RobinState extends State<Robin> with SingleTickerProviderStateMixin {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Robin"),
        ),
        body: Center(child: Text("User data will go here: ")),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text('Chart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
                color: Colors.transparent,
              ),
              title: Text(" "),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text("Distribution"),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ScopedModel.of<AppModel>(context).donate(Category.FOOD);
          },
          icon: Icon(Icons.attach_money),
          label: Text("Donate"),
        ),
      ),
    );
  }
}
