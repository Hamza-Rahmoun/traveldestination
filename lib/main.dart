import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/login-page.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/home-page.dart';
import 'package:travel/screen/login-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: Auth()),
//                ChangeNotifierProxyProvider<Auth, Products>(
//                  builder: (ctx, auth, previousProducts) => Products(
//                    auth.token,
//                    auth.userId,
//                    previousProducts == null ? [] : previousProducts.items,
//                  ),
//                ),
              ],
              child: Consumer<Auth>(
                builder: (ctx, auth, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: auth.isAuth ? HomePage() : LoginPage(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
