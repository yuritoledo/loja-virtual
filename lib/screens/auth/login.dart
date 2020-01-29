import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  void _submit() {
    formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            TextFormField(
              validator: (text) =>
                  text.isEmpty || !text.contains('@') ? 'Email inválido' : null,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextFormField(
              validator: (text) => text.isEmpty ? 'Senha inválida' : null,
              decoration: InputDecoration(
                hintText: 'Senha',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
            RaisedButton(
              onPressed: _submit,
              child: Text(
                'Acessar',
                style: TextStyle(color: Colors.white),
              ),
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
