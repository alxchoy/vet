import 'package:flutter/material.dart';

import './ui/home.dart';
import './ui/auth/login.dart';
import './ui/navigation.dart';
import './ui/pet.dart';
import './ui/result.dart';
import './ui/provider.dart';
import './ui/auth/register.dart';
import './ui/stadistics.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => LoginScreen(),
        '/navigation': (context) => NavigationScreen(),
        // '/pet': (context) => PetScreen(),
        // '/result': (context) => ResultScreen(),
        // '/provider': (context) => ProviderScreen(),
        '/register': (context) => RegisterScreen(),
        '/stadistics': (context) => StadisticsScreen()
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(90, 168, 158, 1.0),
        errorColor: Color.fromRGBO(202, 57, 48, 1.0),
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 20.0)
        )
      ),
    );
  }
}