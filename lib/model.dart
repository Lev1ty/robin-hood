import 'package:flutter/material.dart';

class AppModel extends InheritedWidget {
  const AppModel({
    Key key,
    @required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  static AppModel of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppModel) as AppModel;
  }

  @override
  bool updateShouldNotify(AppModel old) {
    return true;
  }

  Future<bool> login(String username, String password) async {
    return true;
  }
}