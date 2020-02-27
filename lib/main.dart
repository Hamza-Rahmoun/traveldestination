import 'package:flutter/material.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/start-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: StartPage(),
            );
          },
        );
      },
    );
  }
}
