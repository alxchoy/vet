import 'package:flutter/material.dart';

import '../providers/services/client-service.dart';
import '../shared/widgets/vet-input.dart';
import '../utils/helpers.dart';

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
  bool _loading = false;
  var _userName;
  var _userAlias;
  var _userEmail;
  var _userPass;
  var _userConfirmPass;

  void _saveForm({BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_userPass == _userConfirmPass) {
        setState(() => _loading = true);
        final request = {
          "UserName": _userAlias,
          "UserPassword": _userPass,
          "ClientEmail": _userEmail
        };
        final response = await ClientService.createClient(form: request);
        setState(() => _loading = false);
        if (response['code'] == 1) {
          await Navigator.pushNamed(context, '/login');
        }
      } else {
        Helpers.showVetDialog(
          context: context,
          description: 'Su contraseña no ha sido confirmada correctamente',
          btnConfig: {
            'action': () => Navigator.pop(context),
            'color': Color.fromRGBO(202, 57, 48, 1.0),
            'text': 'Aceptar'
          }
        );
      }
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  Widget _showLoading() {
    if (_loading) {
      return Positioned(
        top: 100.0,
        left: 130.0,
        child: Center(
          child: Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[350],
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
              )
            ),
            color: Color.fromRGBO(0, 0, 0, 0.3),
            width: 100.0,
            height: 100.0
          )
        )
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: _autovalidate,
      key: _formKey,
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
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
                  onPressed: () => _saveForm(context: context),
                  padding: EdgeInsets.all(20.0),
                  shape: CircleBorder(),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.end
            ),
            _showLoading()
          ]
        ),
        // child: Column(
        //   children: <Widget>[
        //     VetInput(label: 'Nombre', onSave: (val) => _userName = val),
        //     SizedBox(height: 20.0,),
        //     VetInput(label: 'Usuario', onSave: (val) => _userAlias = val),
        //     SizedBox(height: 20.0,),
        //     VetInput(label: 'Correo', onSave: (val) => _userEmail = val),
        //     SizedBox(height: 20.0,),
        //     VetInput(inputType: 'password', label: 'Contraseña', onSave: (val) => _userPass = val),
        //     SizedBox(height: 20.0,),
        //     VetInput(inputType: 'password', label: 'Confirmar constraseña', onSave: (val) => _userConfirmPass = val),
        //     SizedBox(height: 30.0,),
        //     RawMaterialButton(
        //       child: Icon(Icons.arrow_forward, color: Colors.white, size: 40.0,),
        //       elevation: 4.0,
        //       fillColor: Color.fromRGBO(90, 168, 158, 1.0),
        //       onPressed: () => _saveForm(context: context),
        //       padding: EdgeInsets.all(20.0),
        //       shape: CircleBorder(),
        //     )
        //   ],
        //   crossAxisAlignment: CrossAxisAlignment.end
        // ),
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0)
      )
    );
  }
}