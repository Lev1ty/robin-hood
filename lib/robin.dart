import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';

class Robin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScopedModel.of<AppModel>(context).donate(Category.FOOD);
        },
        icon: Icon(Icons.attach_money),
        label: Text("Donate"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.greenAccent,
      ),
      body: Hero(
        tag: 'Robin',
        child: Material(
          color: Colors.greenAccent,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  title: Hero(
                    tag: 'Robin title',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Robin',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  background: Container(
                    color: Colors.greenAccent,
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
