// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  Future sign_in() async {
    String url = "http://172.20.10.2/flutter_login/login.php";

    final respone = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'password': password.text,
    });

    var data = json.decode(respone.body);
    print(data);
    if (data == "Error") {
      Navigator.pushNamed(context, 'login');
    } else {
      await User.setsignin(true);
      Navigator.pushNamed(context, 'home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'HAYT',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C934D)),
                      ),
                      SizedBox(
                        width: 10, // ระยะห่างระหว่าง "HAYT" กับรูปภาพ
                      ),
                      Image.asset(
                        'assets/images/aaa.png',
                        fit: BoxFit.contain,
                        width: 100,
                        height: 200,
                        color: Color(0xFF6C934D),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF6C934D),
                              width:
                                  2.0), // กำหนดสีเส้นกรอบเมื่อกล่องรับข้อมูลได้รับการโฟกัส
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF6C934D),
                              width:
                                  1.0), // กำหนดสีเส้นกรอบเมื่อกล่องรับข้อมูลไม่ได้รับการโฟกัส
                        ),
                        labelText: 'Username',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: name,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF6C934D), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF6C934D), width: 1.0),
                        ),
                        labelText: 'Password',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: password,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C934D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        bool pass = formKey.currentState!.validate();

                        if (pass) {
                          sign_in();
                        }
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text(
                      " Sign Up now",
                      style: TextStyle(color: Color(0xFF6C934D)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
