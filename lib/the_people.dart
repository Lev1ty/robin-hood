import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'camera.dart';
import 'model.dart';

class ThePeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScopedModel.of<AppModel>(context).withdrawl(250, Category.FOOD);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Camera();
              },
            ),
          );
        },
        icon: Icon(Icons.attach_money),
        label: Text("Withdrawl"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.lightGreen,
      ),
      body: Hero(
        tag: 'The People',
        child: Material(
          color: Colors.lightGreen,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  title: Hero(
                    tag: 'The People title',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'The People',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  background: Container(
                    color: Colors.lightGreen,
                  ),
                  centerTitle: true,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
