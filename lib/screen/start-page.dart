import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel/animation/faded-animation.dart';
import 'package:travel/clippath/custom-clippaint.dart';
import 'package:travel/clippath/custom-clippath.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/login-page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;
  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;
  bool hideIcon = false;
  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        child: Stack(
          children: <Widget>[
            FadeAnimation(
              0.6,
              ClipPath(
                clipper: CustomClipperWidget(),
                child: CustomPaint(
                  painter: MyCustomPainter(),
                  child: Container(
                    height: 60 * SizeConfig.heightMultiplier,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6 * SizeConfig.textMultiplier,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                    1.4,
                    Text(
                      "We promis that you'll have the most \nfuss-free time with us ever.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        height: 1.4,
                        fontSize: 2.5 * SizeConfig.textMultiplier,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                      1.8,
                      AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _widthController,
                                builder: (context, child) => Container(
                                  width: _widthAnimation.value,
                                  height: height < 500
                                      ? 12 * SizeConfig.heightMultiplier
                                      : 10 * SizeConfig.heightMultiplier,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(
                                      4 * SizeConfig.widthMultiplier),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          50 * SizeConfig.widthMultiplier),
                                      color:
                                          Colors.purpleAccent.withOpacity(.4)),
                                  child: InkWell(
                                    onTap: () {
                                      _scaleController.forward();
                                    },
                                    child: Stack(children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) =>
                                                Transform.scale(
                                                    scale:
                                                        _scale2Animation.value,
                                                    child: Container(
                                                      width: height < 500
                                                          ? 8 *
                                                              SizeConfig
                                                                  .widthMultiplier
                                                          : 10.5 *
                                                              SizeConfig
                                                                  .widthMultiplier,
                                                      height: height < 500
                                                          ? 6 *
                                                              SizeConfig
                                                                  .heightMultiplier
                                                          : 6 *
                                                              SizeConfig
                                                                  .heightMultiplier,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.purple),
                                                      child: hideIcon == false
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              color:
                                                                  Colors.white,
                                                              size: 3 *
                                                                  SizeConfig
                                                                      .textMultiplier,
                                                            )
                                                          : Container(),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
