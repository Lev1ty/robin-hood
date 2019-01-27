import 'package:flutter/material.dart';

class Robin extends StatefulWidget {
  @override
  _RobinState createState() => _RobinState();
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
//class _robinState extends State<Robin> {
//  bool _wantDonate = true;


class _RobinState extends State<Robin> with SingleTickerProviderStateMixin {
  AnimationController _controller;


  get height => 48;

  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Robin Hood"),
      ),
      floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(icon: Icon(Icons.add), label: Text("Money"),
        onPressed: (){
      _settingBottomSheet(context);
    },
    ),
      body: Container(
          child: ListView(
            children:  <Widget>[
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
            ],
          )
      ),
    );
        }



void _settingBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.add),
                title: Text("Donation amount")
            ),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Name")
            ),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Example")
            ),
            ListTile(
                leading: Icon(Icons.accessible),
                title: Text("Example")
            ),
          ],

        ),
      );
    },
  );
}






//  @override
//  void initState() {
//    _controller = AnimationController(vsync: this);
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget builder(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("User Name"),
//        ),
//        body: Center(
//          child: ListView(
//              children: list
//          ),
//        ),
//        bottomNavigationBar: BottomNavigationBar(
//          items: <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//                icon: Icon(Icons.pie_chart_outlined, color: Colors.blue[500]),
//                title: Text('Chart')),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.attach_money, color: Colors.transparent),
//                title: Text(" ")),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.map, color: Colors.blue[500]),
//                title: Text('Map'))
//          ],
//        ),
//
//        floatingActionButtonLocation:
//        FloatingActionButtonLocation.centerDocked,
//        floatingActionButton: FloatingActionButton.extended(
//            onPressed: () {},
//            icon: Icon(Icons.attach_money),
//            label: Text("Donate")
//
//
//        )
//
//
//    );
//  }
}