import 'package:flutter/material.dart';
import 'package:organic/components/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

import '../../components/bottom_error_message.dart';
// import '../../components/bottom_success_message.dart';
import '../../services/user_manager.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserManager userManager = Provider.of<UserManager>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState.validate()) {
            if (passwordController.text != confirmPasswordController.text) {
              BottomErrorMessage(
                  context: context, errorMessage: "Senhas não coincidem!");
              return;
            }//TODO change password
            // userManager.ChangePassword(
            //   senhaAntiga: oldPasswordController.text,
            //   senhaNova: passwordController.text,
            //   onFail: (e) {
            //     BottomErrorMessage(context: context, errorMessage: "Erro: $e");
            //   },
            //   onSuccess: () {
            //     Navigator.pop(context);
            //     BottomSuccessMessage(
            //         context: context,
            //         message: "Sua Senha foi Alterada com Sucesso!");
            //   },
            // );
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        label: userManager.loading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : const Icon(
                Icons.check,
                color: Colors.white,
              ),
      ),
      appBar: AppBar(
        title: const Text("Trocar Senha"),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                CustomTextField(
                  title: "Senha Antiga",
                  hintText: "Digite a senha Antiga",
                  controller: oldPasswordController,
                  enabled: !userManager.loading,
                  obscureText: true,
                  validator: (password) {
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                        .minLength(6, msg: "Mínimo de 6 caracteres")
                        .valido(password);
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Nova Senha",
                  hintText: "Digite  a Nova Senha",
                  controller: passwordController,
                  enabled: !userManager.loading,
                  obscureText: true,
                  validator: (senha) {
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                        .minLength(6, msg: "Mínimo de 6 caracteres")
                        .valido(senha);
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Repita a Nova Senha",
                  hintText: "Digite a Nova Senha Novamente",
                  controller: confirmPasswordController,
                  enabled: !userManager.loading,
                  obscureText: true,
                  validator: (senha) {
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                        .minLength(6, msg: "Mínimo de 6 caracteres")
                        .valido(senha);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
