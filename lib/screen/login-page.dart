import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel/animation/faded-animation.dart';
import 'package:travel/model/http-exception.dart';
import 'package:travel/provider/login-page.dart';
import 'package:travel/responsiveui/size-config.dart';

enum AuthMode { Signup, Login }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  AnimationController _controller;
  Animation<Size> _heightAnimation;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 17 * SizeConfig.heightMultiplier),
            end: Size(double.infinity, 24 * SizeConfig.heightMultiplier))
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _heightAnimation.addListener(() => setState(() {}));
  }

  AuthMode _authMode = AuthMode.Login;
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  final _passwordController = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  var _isLoading = false;
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildImageLogin(
              50,
              51,
              51,
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
                        _authMode == AuthMode.Login ? "Login" : "SignUp",
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
                        height: _heightAnimation.value.height,
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
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  height: 8 * SizeConfig.heightMultiplier,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "E-Mail",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              2.2 * SizeConfig.textMultiplier,
                                        )),
//                                    validator: (value) {
//                                      if (value.isEmpty ||
//                                          !value.contains('@')) {
//                                        return 'Invalid email!';
//                                      }
//                                      return null;
//                                    },
                                    validator: (val) =>
                                        !EmailValidator.validate(val, true)
                                            ? 'Not a valid email.'
                                            : null,
                                    onSaved: (value) {
                                      _authData['email'] = value;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  height: 8 * SizeConfig.heightMultiplier,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              2.2 * SizeConfig.textMultiplier,
                                        )),
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 5) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['password'] = value;
                                    },
                                  ),
                                ),
                                if (_authMode == AuthMode.Signup)
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    height: 8 * SizeConfig.heightMultiplier,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                2.2 * SizeConfig.textMultiplier,
                                          )),
                                      obscureText: true,
                                      validator: _authMode == AuthMode.Signup
                                          ? (value) {
                                              if (value !=
                                                  _passwordController.text) {
                                                return 'Passwords do not match!';
                                              }
                                              return null;
                                            }
                                          : null,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: _authMode == AuthMode.Login
                        ? 2.5 * SizeConfig.heightMultiplier
                        : null,
                  ),
                  FadeAnimation(
                      1.9,
                      Center(
                          child: Text(
                        _authMode == AuthMode.Login ? "Forgot Password?" : '',
                        style: TextStyle(
                          color: Color.fromRGBO(196, 135, 198, 1),
                          fontSize: _authMode == AuthMode.Login
                              ? 2 * SizeConfig.textMultiplier
                              : null,
                        ),
                      ))),
                  SizedBox(
                    height: _authMode == AuthMode.Login
                        ? 3 * SizeConfig.heightMultiplier
                        : null,
                  ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    FadeAnimation(
                      1.9,
                      GestureDetector(
                        onTap: _submit,
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
                              _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 2 * SizeConfig.heightMultiplier,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: _authMode == AuthMode.Login
                        ? 3 * SizeConfig.heightMultiplier
                        : 2 * SizeConfig.heightMultiplier,
                  ),
                  FadeAnimation(
                    2,
                    GestureDetector(
                      onTap: () => _switchAuthMode(),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: _authMode == AuthMode.Login
                                      ? 'Create Account'
                                      : 'Already a Member ?',
                                  style: TextStyle(
                                      color: Color.fromRGBO(49, 39, 79, .6),
                                      fontSize: 2 * SizeConfig.textMultiplier)),
                              TextSpan(
                                text: _authMode == AuthMode.Login
                                    ? ''
                                    : ' Log In',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 2 * SizeConfig.textMultiplier,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImageLogin(
      double height, double heightImage1, double heightImage2) {
    return Builder(
      builder: (context) {
        final width = MediaQuery.of(context).size.width;
        return Container(
          height: height * SizeConfig.heightMultiplier,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -5 * SizeConfig.heightMultiplier,
                height: heightImage1 * SizeConfig.heightMultiplier,
                width: width,
                child: FadeAnimation(
                  1,
                  Container(
                    height: 40 * SizeConfig.heightMultiplier,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              ),
              Positioned(
                height: heightImage2 * SizeConfig.heightMultiplier,
                width: width + 10 * SizeConfig.widthMultiplier,
                child: FadeAnimation(
                    1.3,
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/background-2.png'),
                              fit: BoxFit.fill)),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
