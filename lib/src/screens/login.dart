import 'dart:convert';

import 'package:flutter/material.dart';

import '../providers/services/shared-preferences.dart';
import '../providers/services/client-service.dart';
import '../providers/services/lookups-service.dart';

import '../shared/widgets/vet-input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  Text recoveryPassword() {
    return Text(
      'Recuperar contraseña',
      style: TextStyle(
        color: Color.fromRGBO(90, 168, 158, 1.0),
        fontSize: 17.0
      ),
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
          _loadAllLookups();
        }
      },
      padding: EdgeInsets.all(20.0),
      shape: CircleBorder(),
    );
  }

  void _saveTokenResponse() async {
    widget.callback(true);
    final response = await ClientService.login(_userName, _userPassword);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final dataClient = await ClientService.getClientId(data['access_token']);

      SharedPreferencesVet.setToken(data['access_token']);
      SharedPreferencesVet.setClientId(dataClient['idLogIn']);
      Navigator.pushNamed(context, '/navigation');
    } else {
      widget.callback(false);
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load post save token');
    }
  }

  void _loadAllLookups() async {
    final lookups = await LookupsService.loadLookups();
    SharedPreferencesVet.setLookups(json.encode(lookups));
    widget.callback(false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
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