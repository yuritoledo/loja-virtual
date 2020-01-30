import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/auth/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 1, 125, 141),
            buttonColor: Color.fromARGB(255, 1, 125, 141)),
        debugShowCheckedModeBanner: false,
        home: RegisterScreen());
  }
}
