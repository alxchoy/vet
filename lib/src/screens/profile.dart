import 'package:flutter/material.dart';
import 'package:veterinary/src/shared/widgets/vet-combo.dart';

import '../providers/services/shared-preferences.dart';
import '../providers/services/client-service.dart';
import '../providers/models/client-model.dart';

import '../shared/widgets/vet-input.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<dynamic> _getClientData() async {
    final token = await SharedPreferencesVet.getToken();
    final clientId = await SharedPreferencesVet.getClientId();
    final data = await ClientService.getClientData(token, clientId);

    return data;
  }

  Widget header() {
    return Row(
      children: <Widget>[
        Container(
          child: Center(
            child: Icon(Icons.person, color: Colors.grey[700], size: 50)
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey[700], width: 2.0)
          ),
          padding: EdgeInsets.all(10.0),
        ),
        SizedBox(width: 15.0),
        Column(
          children: <Widget>[
            Text('Hola,', style: TextStyle(fontSize: 20)),
            Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            header(),
            SizedBox(height: 40.0),
            FutureBuilder(
              future: _getClientData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  return snapshot.data != null ? ProfileForm(clientData: snapshot.data) : Text('Pending...');
                } else {
                  return Text('Error');
                }
              },
            )
          ],
        ),
        padding: EdgeInsets.all(20.0)
      )
    );
  }
}

class ProfileForm extends StatefulWidget {
  final Client clientData;

  ProfileForm({this.clientData});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String _userName;
  String _userDocumentNumber;
  String _userEmail;
  String _userAlias;
  String _userCurrentPass;
  String _userNewPass;
  String _userValidPass;

  FlatButton btnForm() {
    return FlatButton(
      child: Container(
        child: Center(
          child: Text(
            'Guardar'.toUpperCase(),
            style: TextStyle(fontSize: 24, color: Colors.white),
          )
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.5), blurRadius: 5.0)
          ],
          color: Color.fromRGBO(90, 168, 158, 1.0)
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
        width: double.infinity,
      ),
      color: Color.fromRGBO(0, 0, 0, 0.0),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
        } else {
          setState(() => _autovalidate = true);
        }
      },
      padding: EdgeInsets.all(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: _autovalidate,
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            VetInput(
              label: 'Nombre',
              onSave: (val) => _userDocumentNumber = val,
              initValue: widget.clientData.clientFullName
            ),
            SizedBox(height: 20.0),
            VetCombo(
              label: 'Tipo documento',
              lookupType: 'documents',
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              }
            ),
            SizedBox(height: 20.0),
            VetInput(
              label: 'Nro. documento',
              onSave: (val) => _userDocumentNumber = val,
              initValue: widget.clientData.clientDocumentNumber
            ),
            SizedBox(height: 20.0),
            VetInput(label: 'Correo', onSave: (val) => _userEmail = val, initValue: widget.clientData.clientEmail),
            SizedBox(height: 20.0),
            VetInput(label: 'Usuario', onSave: (val) => _userAlias = val, initValue: widget.clientData.userName),
            Container(
              child: Text('Contraseña', style: TextStyle(fontSize: 22.0)),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300], width: 2.0))),
              margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
              padding: EdgeInsets.only(top: 20.0),
              width: double.infinity
            ),
            VetInput(label: 'Actual', onSave: (val) => _userCurrentPass = val, inputType: 'password',),
            SizedBox(height: 20.0),
            VetInput(label: 'Nueva contraseña', onSave: (val) => _userNewPass = val, inputType: 'password'),
            SizedBox(height: 20.0),
            VetInput(label: 'Repetir contraseña', onSave: (val) => _userValidPass = val, inputType: 'password'),
            SizedBox(height: 40.0),
            btnForm()
          ],
        )
      )
    );
  }
}