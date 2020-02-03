import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  void submit() {
    formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro'), centerTitle: true),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            buildTextFormField('Nome', 'O nome é obrigatório'),
            buildTextFormField('Email', 'O email é obrigatório'),
            buildTextFormField('Senha', 'A senha é obrigatória!'),
            buildTextFormField('Endereço', 'O endereço é obrigatório!'),
            SizedBox(height: 32),
            RaisedButton(
              onPressed: submit,
              child: Text('CRIAR CONTA', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(String name, String errorMessage) {
    return TextFormField(
      decoration: InputDecoration(hintText: name),
      obscureText: name == 'Senha' ? true : false,
      validator: (text) => text.isEmpty ? errorMessage : null,
    );
  }
}
