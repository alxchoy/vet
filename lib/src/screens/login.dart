import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: SafeArea(
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
                )
              ),
              Container(
                child: LoginForm(),
              ),
              Container(
                child: Image.asset('assets/img/pet.png', fit: BoxFit.cover,),
                // margin: EdgeInsets.only(top: 10.0),
                width: double.infinity
              )
            ],
          ),
          color: Colors.white
        ),
      )
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _userName;
  String _userPassword;

  final recoveryPass = Text(
    'Recuperar contraseña',
    style: TextStyle(
      color: Color.fromRGBO(90, 168, 158, 1.0),
      fontSize: 17.0
    ),
  );

  TextFormField userInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Usuario',
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
      onSaved: (val) => _userName = val,
      validator: (val) {
        if (val.isEmpty) {
          return 'Campo requerido';
        }
      }
    );
  }

  TextFormField userPassowrd() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Contraseña',
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
      onSaved: (val) => _userPassword = val,
      validator: (val) {
        if (val.isEmpty) {
          return 'Campo requerido';
        }
      }
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
          print(_userName);
          print(_userPassword);
        }
      },
      padding: EdgeInsets.all(20.0),
      shape: CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            userInput(),
            SizedBox(height: 20.0,),
            userPassowrd(),
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  recoveryPass,
                  SizedBox(height: 25.0,),
                  formBtn()
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              margin: EdgeInsets.only(top: 20.0),
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(0, 30, 0, 7),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      )
    );
  }
}