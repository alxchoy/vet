import 'package:flutter/material.dart';

import 'package:veterinary/src/utils/helpers.dart';
import 'package:veterinary/src/widgets/vet_input.dart';

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

  void _saveForm({BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_userPass == _userConfirmPass) {
        final request = {
          "UserName": _userAlias,
          "UserPassword": _userPass,
          "ClientEmail": _userEmail
        };
        // final response = await ClientService.createClient(form: request);

        // if (response['code'] == 1) {
        //   await Navigator.pushNamed(context, '/login');
        // }
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
            )
          ]
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0)
      )
    );
  }
}