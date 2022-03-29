import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes.dart';
import '../../../services/user_manager.dart';

class BackLayer extends StatelessWidget {
  final double headerheight;

  const BackLayer({@required this.headerheight});

  @override
  Widget build(BuildContext context) {
    final UserManager userManager = Provider.of<UserManager>(context);
    Widget _createDrawerItem(
        {IconData icon, String text, GestureTapCallback onTap}) {
      return SizedBox(
        height: 56,
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
          onTap: onTap,
        ),
      );
    }

    return ListView(
      children: [
        if (userManager.isLoggedIn)
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Sair',
            onTap: () async {
              if (await confirm(
                context,
                title: const Text('Sair'),
                content: const Text('Tem certeza de que quer sair?'),
                textOK: const Text('Continuar'),
                textCancel: const Text('Cancelar'),
              )) {
                Navigator.pushReplacementNamed(
                    context, AppRoutes.NAVIGATION_SCREEN);
                return userManager.signOut();
              }
            },
          ),
        _createDrawerItem(
          icon: Icons.help,
          text: 'Ajuda e Suporte',
          onTap: () => Navigator.pushNamed(context, AppRoutes.HELP_SCREEN),
        ),
        _createDrawerItem(
          icon: Icons.collections_bookmark,
          text: 'Sobre Nós',
          onTap: () => Navigator.pushNamed(context, AppRoutes.ABOUT_US_SCREEN),
        ),
        _createDrawerItem(
            icon: Icons.article_outlined,
            text: 'Termos e Condições',
            onTap: () => launch("https://organic.app.br/legal/terms/")),
        _createDrawerItem(
            icon: Icons.article,
            text: 'Política de privacidade',
            onTap: () =>
                launch("https://organic.app.br/legal/privacy-policy/")),
        SizedBox(height: headerheight)
      ],
    );
  }
}
