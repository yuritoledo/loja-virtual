import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/auth/login.dart';
import 'package:lojavirtual/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 1, 125, 141),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen());
  }
}
