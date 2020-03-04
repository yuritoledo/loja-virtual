import 'package:flutter/material.dart';
import 'package:lojavirtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  void _submit() {
    final bool isValid = formKey.currentState.validate();
    if (!isValid) return;

    final Map<String, dynamic> userData = {
      'name': nameController.text,
      'email': emailController.text,
      'address': addressController.text,
    };

    ScopedModel.of<UserModel>(formKey.currentContext).signUp(
        userData: userData,
        pass: passwordController.text,
        onSuccess: onSuccess,
        onFail: onFail);
  }

  void onSuccess() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(scaffoldKey.currentState.context).primaryColor,
      content: Text(
        'Usuário registrado com sucesso!',
      ),
    ));
  }

  void onFail() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        'Ocorreu um erro, tente novamente',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro'), centerTitle: true),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: <Widget>[
                buildTextFormField(
                    name: 'Nome',
                    errorMessage: 'O nome é obrigatório',
                    controller: nameController),
                buildTextFormField(
                    name: 'Email',
                    errorMessage: 'O email é obrigatório',
                    controller: emailController),
                buildTextFormField(
                    name: 'Senha',
                    errorMessage: 'A senha é obrigatória!',
                    controller: passwordController),
                buildTextFormField(
                    name: 'Endereço',
                    errorMessage: 'O endereço é obrigatório!',
                    controller: addressController),
                SizedBox(height: 32),
                RaisedButton(
                  onPressed: model.isLoading ? null : _submit,
                  child: Text('CRIAR CONTA',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTextFormField(
      {String name, String errorMessage, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: name),
      obscureText: name == 'Senha' ? true : false,
      validator: (text) => text.isEmpty ? errorMessage : null,
    );
  }
}
