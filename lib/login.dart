import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';
import 'the_people.dart';
import 'robin.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Hero(
                  tag: 'Robin',
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      color: Colors.greenAccent,
                      height: 400,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Robin();
                              },
                            ),
                          );
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Hero(
                                tag: 'Robin title',
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    height: 100,
                    color: Colors.redAccent,
                    child: InkWell(
                      onTap: () async {
                        ScopedModel.of<AppModel>(context).login();
                      },
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'The People',
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      height: 400,
                      color: Colors.lightGreen,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ThePeople();
                              },
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Hero(
                              tag: 'The People title',
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
