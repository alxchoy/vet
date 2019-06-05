import 'package:flutter/material.dart';

import '../providers/services/client-service.dart';
import '../shared/widgets/vet-input.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Widget _header() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          Padding(
            child: Text('Regístrate', style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold)),
            padding: EdgeInsets.only(left: 35.0),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Column(
                  children: <Widget>[
                    _header(),
                    RegisterForm()
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}

class RegisterForm extends StatefulWidget {

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  var _userName;
  var _userAlias;
  var _userEmail;
  var _userPass;
  var _userConfirmPass;

  void _saveForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_userPass == _userConfirmPass) {
        // final request = {
        //   "UserName" : "usuarioApp",
        //   "UserPassword" : "123456",
        //   "ClientEmail" : "luis@multiplica.com"
        // }
        // final response = await ClientService.createClient(form: )
      }
    } else {
      setState(() {
        _autovalidate = true;
      });
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
            VetInput(label: 'Nombre', onSave: (val) => _userName = val),
            SizedBox(height: 20.0,),
            VetInput(label: 'Usuario', onSave: (val) => _userAlias = val),
            SizedBox(height: 20.0,),
            VetInput(label: 'Correo', onSave: (val) => _userEmail = val),
            SizedBox(height: 20.0,),
            VetInput(inputType: 'password', label: 'Contraseña', onSave: (val) => _userPass = val),
            SizedBox(height: 20.0,),
            VetInput(inputType: 'password', label: 'Confirmar constraseña', onSave: (val) => _userConfirmPass = val),
            SizedBox(height: 30.0,),
            RawMaterialButton(
              child: Icon(Icons.arrow_forward, color: Colors.white, size: 40.0,),
              elevation: 4.0,
              fillColor: Color.fromRGBO(90, 168, 158, 1.0),
              onPressed: _saveForm,
              padding: EdgeInsets.all(20.0),
              shape: CircleBorder(),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0)
      )
    );
  }
}