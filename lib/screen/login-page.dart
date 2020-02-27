import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel/animation/faded-animation.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/home-page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50 * SizeConfig.heightMultiplier,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -5 * SizeConfig.heightMultiplier,
                    height: 51 * SizeConfig.heightMultiplier,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          height: 40 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/background.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: 51 * SizeConfig.heightMultiplier,
                    width: width + 5 * SizeConfig.widthMultiplier,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/background-2.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 13 * SizeConfig.widthMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 4 * SizeConfig.textMultiplier,
                        ),
                      )),
                  SizedBox(
                    height: 2.5 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 10 * SizeConfig.heightMultiplier,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 2.2 * SizeConfig.textMultiplier,
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 10 * SizeConfig.heightMultiplier,
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 2.2 * SizeConfig.textMultiplier,
                                    )),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 2.5 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                      1.7,
                      Center(
                          child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color.fromRGBO(196, 135, 198, 1),
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                      ))),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                      1.9,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.scale,
                                child: HomePage(),
                              ));
                        },
                        child: Container(
                          height: 8 * SizeConfig.heightMultiplier,
                          width: 35 * SizeConfig.widthMultiplier,
                          margin: EdgeInsets.symmetric(
                              horizontal: 18 * SizeConfig.widthMultiplier),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                      2,
                      Center(
                          child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, .6),
                            fontSize: 2 * SizeConfig.textMultiplier),
                      ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
