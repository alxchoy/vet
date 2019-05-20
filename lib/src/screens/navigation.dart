import 'package:flutter/material.dart';

import './bandeja.dart';
import './profile.dart';
import './subscription.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentScreen = 0;
  final List<Widget> _screens = [
    BandejaScreen(),
    ProfileScreen(),
    SubscriptionScreen()
  ];

  void _onTabNav(idx) {
    setState(() {
      _currentScreen = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Flutter'),
      ),
      body: _screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Mis mascotas')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Mi perfil')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Subscripción')
          )
        ],
        onTap: _onTabNav,
      ),
    );
  }
}