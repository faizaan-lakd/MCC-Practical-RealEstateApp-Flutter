import 'package:flutter/material.dart';
import 'package:real_estate_app/landing.dart';
import 'package:real_estate_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/firebase.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Real Estate Application'),
          centerTitle: true,
          backgroundColor: Color(0xff442243),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 60, 10, 50),
                      child: Text(
                        'Find your Dream Home',
                        style: GoogleFonts.play(
                            color: Color(0xff442243),
                            fontSize: ScreenUtil().setSp(26.0),
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.play(
                            color: Color(0xff442243),
                            fontSize: ScreenUtil().setSp(26.0),
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: buildEmailFormField()),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: buildPasswordFormField()),
                  Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textColor: Colors.white,
                          color: Color(0xff442243),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // if all are valid then go to success screen
                              try {
                                UserCredential user = await FirebaseAuth
                                    .instance
                                    .signInWithEmailAndPassword(
                                        email: email.toString(),
                                        password: password.toString());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('user-not-found');
                                  return null;
                                } else if (e.code == 'wrong-password') {
                                  print('wrong-password');
                                  return null;
                                }
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandingScreen()),
                              );
                            }
                          })),
                  Container(
                      child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 75,
                      ),
                      Text("Don't have an account?"),
                      FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.play(
                                color: Color(0xff442243),
                                fontSize: ScreenUtil().setSp(20.0),
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpForm()),
                            );
                          })
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )),
                ],
              )),
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (String? newValue) => email = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter an E-mail";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter your email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (String? newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password cannot be empty";
        } else if (value.length < 8) {
          return "Password should be 8 characters long";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter your password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
