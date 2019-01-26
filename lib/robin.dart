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
//    var color = Colors.grey[50];
//    var icon = Icons.accessible;
//    var label = "Test2";
    return Scaffold(
      appBar: AppBar(
        title: Text("User Name"),
      )
        bottomNavigationBar: BottomNavigationBar(
            children: [
              Container(
                child: Column(
                  height: 48;
                  length: 48;

//                  _buildbuttoncolumn(color, icon, label)
    )
        ],

    ), items: <BottomNavigationBarItem>[],
    )
      body: Center(
        child: Text("Statistical Data will go here")
      )
    floatingActionButton: FloatingActionButton(
      onPressed: (),
      child: Icon(Icons.attach_money),

    ),
    )

        ]

      ),
    )

  }
//  Column _buildbuttoncolumn( Color color IconData icon String label){
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        Container(
//          child: Text(
//            "Test1"
//  )
//  )
//  ]
//    )
}
  }
}

//Widget user_title
//user_title = Container(
//padding: const EdgeInsets.all(32.0)
//child: Row(
//children: [
//Expanded(
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//child: Container(
//padding: const EdgeInsets.all(32),
//child: Text(
//"User Name",
//style: TextStyle(
//fontWeight: FontWeight.bold
//)
//)
//)