import 'package:flutter/material.dart';

import 'package:veterinary/src/widgets/vet_input.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String _userName;
  String _userPassword;

  void _validateForm({BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // await _bloc.fetchToken(userName: _userName, password: _userPassword);
      print('validate login form');
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
            VetInput(label: 'Contraseña', inputType: 'password', onSave: (val) => _userPassword = val),
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  Text(
                    'Recuperar contraseña',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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

