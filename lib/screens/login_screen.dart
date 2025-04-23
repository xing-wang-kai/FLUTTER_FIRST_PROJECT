import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/services/auth_services.dart';
import 'package:my_frist_flutter_project/widgets/confirmation_dialog.dart';
import 'package:my_frist_flutter_project/widgets/exception_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          border: Border.all(width: 1, color: Colors.blue),
          color: Colors.blue[50],
        ),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.ac_unit_sharp,
                    size: 64,
                    color: Colors.blueAccent,
                  ),
                  const Text(
                    "Simple Task System",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "by KoderSolutions",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 2, color: Colors.blue),
                  ),
                  const Text("Entre ou Registre-se"),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(label: Text("E-mail")),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(label: Text("Password")),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 16,
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: const Text("Continuar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await service
          .loggin(email: email, password: password)
          .then((resultRegister) {
            if (resultRegister) {
              Navigator.pushReplacementNamed(context, "home");
            }
          })
          .catchError((error) {
            var innerError = error as HttpException;
            showExceptionDialog(context, content: innerError.message);
          }, test: (error) => error is HttpException)
          .catchError((error) {
            var innerError = error as TimeoutException;
            if (innerError.message != null) {
              showExceptionDialog(
                context,
                content:
                    "O tempo da requisição ultrapassou o limite esperado, tente novamente mais tarde!",
              );
            }
          }, test: (error) => error is TimeoutException);
    } on UserNotFindExceptions {
      showConfirmationDialog(
        context,
        title: "Usuário não existe",
        content:
            "Deseja criar um novo usuário com o e-mail $email e senha informados?",
        affirmativeOption: "CRIAR",
      ).then((response) {
        if (response != null && response) {
          service.register(email: email, password: password).then((
            resultRegister,
          ) {
            if (resultRegister) {
              Navigator.pushReplacementNamed(context, "home");
            }
          });
        }
      });
    }
  }
}
