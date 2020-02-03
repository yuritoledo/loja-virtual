import 'package:flutter/material.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:lojavirtual/screens/auth/register.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  void _submit() {
    final bool isValid = formKey.currentState.validate();
    if (!isValid) return;

    ScopedModel.of<UserModel>(formKey.currentContext).signIn();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterScreen()));
            },
            child: Text(
              'CRIAR CONTA',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return CircularProgressIndicator();
          }

          return Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) => text.isEmpty || !text.contains('@')
                      ? 'Email inválido'
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (text) => text.isEmpty ? 'Senha inválida' : null,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      model.signIn();
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: _submit,
                  child: Text(
                    'ACESSAR',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
