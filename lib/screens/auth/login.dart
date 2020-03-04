import 'package:flutter/material.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:lojavirtual/screens/auth/register.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    final bool isValid = _formKey.currentState.validate();
    if (!isValid) return;

    ScopedModel.of<UserModel>(context).signIn(
        email: _emailController.text,
        password: _passwordController.text,
        onSuccess: onSuccessSubmit,
        onFail: onFailSubmit);
  }

  void onSuccessSubmit() {
    Navigator.of(context).pop();
  }

  void onFailSubmit() {
    _showSnackbar(text: 'Erro! Verifique os dados e tente novamente');
  }

  void _showSnackbar({String text, bool isError = true}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor:
          isError ? Colors.redAccent : Theme.of(context).primaryColor,
    ));
  }

  void _resetPassword() {
    var email = _emailController.text;

    if (email.isEmpty) {
      _showSnackbar(text: 'Informe um email!');
      return;
    }
    _showSnackbar(
        text: 'Sucesso! Verique em sua caixa de entrada :)', isError: false);
    ScopedModel.of<UserModel>(context).resetPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => RegisterScreen()));
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
            return Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) => text.isEmpty || !text.contains('@')
                      ? 'Email inválido'
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (text) => text.isEmpty ? 'Senha inválida' : null,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: _resetPassword,
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: model.isLoading ? null : _submit,
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
