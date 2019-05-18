import 'dart:convert';

import 'package:flutter/material.dart';

import '../providers/services/shared-preferences.dart';
import '../providers/services/auth-service.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loadingRequest = false;

  void loadRequest(loading) {
    setState(() {
      loadingRequest = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Column(
                    children: <Widget>[
                      LoginHeader(),
                      LoginForm(callback: loadRequest)
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
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: loadingRequest ? Container(
                    child: Center(child: Loading()),
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ) : Container()
                ),
              ]
            )
          ),
          color: Colors.white,
          height: MediaQuery.of(context).size.height
        ),
      )
    );
  }
}

class LoginForm extends StatefulWidget {
  final callback;

  LoginForm({this.callback});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  static String _userName;
  static String _userPassword;

  Map<String, dynamic> _userInput = {
    'label': 'Usuario',
    'onSave': (val) => _userName = val,
    'obscureText': false,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _passInput = {
    'label': 'Contraseña',
    'onSave': (val) => _userPassword = val,
    'obscureText': true,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Text recoveryPassword() {
    return Text(
      'Recuperar contraseña',
      style: TextStyle(
        color: Color.fromRGBO(90, 168, 158, 1.0),
        fontSize: 17.0
      ),
    );
  }

  TextFormField inputForm(Map<String, dynamic> inputConfig) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: inputConfig['label'],
        labelStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 18
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey[350]),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27.0),
          borderSide: BorderSide(color: Colors.grey[350]),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0)
      ),
      obscureText: inputConfig['obscureText'],
      onSaved: inputConfig['onSave'],
      validator: inputConfig['validator']
    );
  }

  RawMaterialButton formBtn() {
    return RawMaterialButton(
      child: Icon(Icons.arrow_forward, color: Colors.white, size: 40.0,),
      elevation: 4.0,
      fillColor: Color.fromRGBO(90, 168, 158, 1.0),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _saveTokenResponse();
        }
      },
      padding: EdgeInsets.all(20.0),
      shape: CircleBorder(),
    );
  }

  void _saveTokenResponse() async {
    widget.callback(true);
    final response = await AuthService.login(_userName, _userPassword);

    if (response.statusCode == 200) {
      widget.callback(false);
      final data = json.decode(response.body);
      print(data['access_token']);
      SharedPreferencesVet.setToken(data['access_token']);
    } else {
      widget.callback(false);
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            inputForm(_userInput),
            SizedBox(height: 20.0,),
            inputForm(_passInput),
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  recoveryPassword(),
                  SizedBox(height: 20.0,),
                  formBtn()
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

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          Padding(
            child: Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold
              ),
            ),
            padding: EdgeInsets.only(left: 35.0),
          ),
          Padding(
            child: Text(
              'Regístrate para ingresar',
              style: TextStyle(
                fontSize: 18.0
              ),
            ),
            padding: EdgeInsets.only(left: 35.0),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.grey[350],
      valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
    );
  }
}