import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';

class ThePeople extends StatefulWidget {
  @override
  _ThePeopleState createState() => _ThePeopleState();
}

class _ThePeopleState extends State<ThePeople>
    with SingleTickerProviderStateMixin {
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
          title: Text('The People'),
        ),
        body: Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
//            ScopedModel.of<AppModel>(context).withdrawl(250, Category.FOOD);
            Navigator.pushNamed(context, 'camera');
          },
          child: Icon(Icons.photo_camera),
        ),
      ),
    );
  }
}
