import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user_manager.dart';
import '../init_screen/init_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../search_screen/search_screen.dart';


class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  final _screens = [
    InitScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final UserManager userManager = Provider.of<UserManager>(context);
    userManager.isLoggedIn;
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (indice) {
          setState(() {
            _currentIndex = indice;
          });
        },
        fixedColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Pesquisar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
