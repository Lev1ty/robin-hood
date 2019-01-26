import 'package:flutter/material.dart';





        ],
      ),
    ]
)

)
    ]
)
)

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
    return Container();
    Widget user_title = Container(
        padding: const EdgeInsets.all(32.0)
    child: Row(
        children: [
        Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        child: Container(
        padding: const EdgeInsets.all(32),
    child: Text(
    "User Name",
    style: TextStyle(
    fontWeight: FontWeight.bold
    )
    )
    )
  }
}
