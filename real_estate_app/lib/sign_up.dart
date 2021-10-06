import 'package:flutter/material.dart';
import 'package:real_estate_app/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:real_estate_app/firebase.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff442243),
          title: Text("Sign Up"),
          centerTitle: true,
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
                      padding: EdgeInsets.fromLTRB(10, 100, 10, 30),
                      child: Text(
                        'Sign Up',
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
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: buildConformPassFormField()),
                  Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textColor: Colors.white,
                          color: Color(0xff442243),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            print(email);
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await signUp(
                                  email.toString(), password.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            }
                          })),
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password cannot be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Re-enter your password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
