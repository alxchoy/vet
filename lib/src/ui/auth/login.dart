 import 'dart:async';

import 'package:flutter/material.dart';

import './login_form.dart';
import './auth_header.dart';
import '../../bloc/bloc_provider.dart';
import '../../bloc/login_bloc.dart';
import '../../bloc/form_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;
  FormBloc _formBloc;

  Map<String, StreamController> inputs = {
    'userName': StreamController<String>(),
    'password': StreamController<String>()
  };

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc();
    _formBloc = FormBloc(inputsStream: inputs);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: _bloc,
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
                        BlocProvider<FormBloc>(
                          bloc: _formBloc,
                          child: LoginForm(navigate: _goToNavigation)
                        )
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