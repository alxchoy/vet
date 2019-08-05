import 'package:flutter/material.dart';

import '../../bloc/providers/login_bloc_provider.dart';
import './login_form.dart';
import './auth_header.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Column(
                      children: <Widget>[
                        AuthHeader(title: 'Bienvenido', subTitle: 'Regístrate para ingresar'),
                        LoginForm(navigate: _goToNavigation)
                      ]
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    height: 200.0,
                    child: Container(
                      color: Colors.red,
                      child: Image.asset('assets/img/pet.png', fit: BoxFit.cover)
                    )
                  ),
                ]
              )
            ),
            color: Colors.white,
            height: MediaQuery.of(context).size.height
          ),
        )
      )
    );
  }

  _goToNavigation() {
    Navigator.pushNamed(context, '/navigation');
  }
}