import 'dart:io';

import 'package:flutter/material.dart';

import '../../bloc/login_bloc.dart';
import '../../bloc/providers/login_bloc_provider.dart';
import '../../shared/widgets/vet-input.dart';

class LoginForm extends StatefulWidget {
  final Function navigate;

  LoginForm({this.navigate});

  @override
  _LoginFormState createState() => _LoginFormState(callback: navigate);
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String _userName;
  String _userPassword;
  Function callback;

  _LoginFormState({this.callback});

  @override
  void didChangeDependencies() {
    _bloc = LoginBlocProvider.of(context);
    super.didChangeDependencies();
  }

  void _validateForm({BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _bloc.fetchUserToken(userName: _userName, password: _userPassword, context: context);
      callback();
    } else {
      setState(() => _autovalidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: _autovalidate,
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            VetInput(label: 'Usuario', onSave: (val) => _userName = val),
            SizedBox(height: 20.0,),
            VetInput(label: 'Contraseña', onSave: (val) => _userPassword = val, inputType: 'password'),
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  Text(
                    'Recuperar contraseña',
                    style: TextStyle(
                      color: Color.fromRGBO(90, 168, 158, 1.0),
                      fontSize: 17.0
                    )
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 80.0,
                    child: RawMaterialButton(
                      child: Icon(Icons.arrow_forward, color: Colors.white, size: 40.0),
                      shape: CircleBorder(),
                      elevation: 5.0,
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: () => _validateForm(context: context)
                    )
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              margin: EdgeInsets.only(top: 15.0),
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(0, 30, 0, 7),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      )
    );
  }
}

