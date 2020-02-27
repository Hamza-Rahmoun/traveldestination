import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value();
      },
      child: Scaffold(
        body: Center(
          child: Text('home page'),
        ),
      ),
    );
  }
}
