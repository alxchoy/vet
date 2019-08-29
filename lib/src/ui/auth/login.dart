import 'package:flutter/material.dart';

import './auth_header.dart';
import './forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
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
                Positioned(
                  child: Column(
                    children: <Widget>[
                      AuthHeader(title: 'Bienvenido', subTitle: 'Regístrate para ingresar'),
                      LoginForm()
                    ]
                  )
                ),
              ]
            ),
            color: Colors.white,
            height: MediaQuery.of(context).size.height
          ),
        )
      )
    );
  }
}