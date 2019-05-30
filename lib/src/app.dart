import 'package:flutter/material.dart';

import './screens/home.dart';
import './screens/login.dart';
import './screens/navigation.dart';
import './screens/pet.dart';
import './screens/result.dart';
import './screens/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => LoginScreen(),
        '/navigation': (context) => NavigationScreen(),
        '/pet': (context) => PetScreen(),
        '/result': (context) => ResultScreen(),
        '/provider': (context) => ProviderScreen()
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(90, 168, 158, 1.0)
      ),
    );
  }
}