import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user_manager.dart';
import 'components/back_layer.dart';
import 'components/front_layer_defalt.dart';
import 'components/front_layer_loged.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserManager _userManager = Provider.of<UserManager>(context);
    final double _headerHeight = MediaQuery.of(context).size.height -
        112 -
        (_userManager.isLoggedIn ? 5 : 4) * 56 -
        MediaQuery.of(context).padding.top;

    return BackdropScaffold(
      frontLayerScrim: Theme.of(context).primaryColor.withOpacity(0.5),
      backLayerBackgroundColor: Colors.white,
      appBar: BackdropAppBar(
        leading: BackdropToggleButton(color: Theme.of(context).primaryColor),
        elevation: 6.0,
        title: const Text("Meus Anúncios"),
      ),
      headerHeight: _headerHeight,
      frontLayer: _userManager.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _userManager.isLoggedIn
              ? FrontLayerLogged()
              : FrontLayerDefault(),
      frontLayerBorderRadius: BorderRadius.zero,
      backLayer: BackLayer(headerheight: _headerHeight),
    );
  }
}
