import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

import '../../components/bottom_error_message.dart';
import '../../components/button.dart';
import '../../components/custom_text_field.dart';
import '../../models/user.dart';
import '../../routes.dart';
import '../../services/user_manager.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.SINGUP_SCREEN);
              },
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: const Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 14),
              ))
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    CustomTextField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        return Validador()
                            .add(Validar.EMAIL, msg: "E-mail inválido")
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(email);
                      },
                      title: "E-mail",
                      hintText: "Digite seu E-mail",
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passwordController,
                      enabled: !userManager.loading,
                      autocorrect: false,
                      obscureText: true,
                      validator: (senha) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .minLength(6, msg: "Mínimo de 6 caracteres")
                            .valido(senha);
                      },
                      title: "Senha",
                      hintText: "Digite sua Senha",
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: userManager.loading
                    //         ? null
                    //         : () {
                    //             Navigator.pushNamed(
                    //                 context, AppRoutes.RECOVER_PASSWORD_SCREEN);
                    //           },
                    //     style: TextButton.styleFrom(
                    //         primary: Colors.black, padding: EdgeInsets.zero),
                    //     child: const Text("Esqueci minha senha"),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Button(
                      isLoading: userManager.loading,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          userManager.Login(
                            user: User(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                            onFail: (e) {
                              BottomErrorMessage(
                                  context: context,
                                  errorMessage: "Falha ao entrar: $e");
                            },
                            onSuccess: () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      text: "Entrar",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
