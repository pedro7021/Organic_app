import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

import '../../components/bottom_error_message.dart';
import '../../components/button.dart';
import '../../components/custom_text_field.dart';
import '../../models/user.dart';
import '../../routes.dart';
import '../../services/user_manager.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    CustomTextField(
                      title: "Nome",
                      hintText: "Digite seu Nome",
                      enabled: !userManager.loading,
                      validator: (nome) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(nome);
                      },
                      onSaved: (nome) => _user.name = nome,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      title: "E-mail",
                      hintText: "Digite seu E-mail",
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        return Validador()
                            .add(Validar.EMAIL, msg: "E-mail inválido")
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(email);
                      },
                      onSaved: (email) => _user.email = email,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      title: "Senha",
                      hintText: "Digite uma Senha",
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .minLength(6, msg: "Mínimo de 6 caracteres")
                            .valido(password);
                      },
                      onSaved: (password) => _user.password = password,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      title: "Confirmar Senha",
                      hintText: "Repita a Senha",
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (confirmPassword) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .minLength(6, msg: "Mínimo de 6 caracteres")
                            .valido(confirmPassword);
                      },
                      onSaved: (confirmPassword) =>
                          _user.confirmPassword = confirmPassword,
                    ),
                    const SizedBox(height: 16),
                    Button(
                      isLoading: userManager.loading,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (_user.password != _user.confirmPassword) {
                            BottomErrorMessage(
                                context: context,
                                errorMessage: "Senhas não coincidem!");
                            return;
                          }
                          // TODO SignUp
                          userManager.signUp(
                            user: _user,
                            onFail: (e) {
                              BottomErrorMessage(
                                  context: context,
                                  errorMessage: "Falha ao Cadastrar: $e");
                            },
                            onSuccess: () {
                              Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(
                                      AppRoutes.NAVIGATION_SCREEN));
                            },
                          );
                        }
                      },
                      text: "Criar Conta",
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
