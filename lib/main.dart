import 'package:flutter/material.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Color.fromARGB(255, 1, 125, 141),
              buttonColor: Color.fromARGB(255, 1, 125, 141)),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()),
    );
    // home: RegisterScreen());
  }
}
