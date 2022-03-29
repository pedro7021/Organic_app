import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/user_manager.dart';

class MyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserManager userManager = Provider.of<UserManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Conta"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nome:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    // TODO Correções
                    "teste",
                    // userManager.user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(
                      //     context, AppRoutes.CHANGE_NAME_SCREEN);
                    })
              ],
            ),
            const Divider(
              color: Colors.black54,
            ),
            const Text(
              "Senha:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    "Trocar senha",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.CHANGE_PASSWORD_SCREEN);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
