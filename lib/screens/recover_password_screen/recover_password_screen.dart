import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

// import '../../components/bottom_error_message.dart';
// import '../../components/bottom_success_message.dart';
import '../../services/user_manager.dart';

class RecoverPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserManager _userManager = Provider.of<UserManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar Senha"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                const Text(
                  "Esqueceu sua Senha?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  "Por favor, informe o E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para a restauração de sua senha.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: emailController,
                  enabled: !_userManager.loading,
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    return Validador()
                        .add(Validar.EMAIL, msg: "E-mail inválido")
                        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                        .valido(email);
                  },
                ), //email
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: _userManager.loading
                      ? null
                      : () {
                          if (formKey.currentState.validate()) {
                            // TODO recover password
                            // _userManager.recoverPassword(
                            //   email: emailController.text,
                            //   onFail: (e) {
                            //     BottomErrorMessage(
                            //         context: context, errorMessage: "Erro: $e");
                            //   },
                            //   onSuccess: () {
                            //     Navigator.pop(context);
                            //     BottomSuccessMessage(
                            //         context: context,
                            //         message:
                            //             "Um email de recuperação com as instruções necessárias foram enviadas para: ${emailController.text}");
                            //   },
                            // );
                          }
                        },
                  child: _userManager.loading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : const Text(
                          "Enviar",
                          style: TextStyle(fontSize: 18),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
