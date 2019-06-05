import 'package:flutter/material.dart';
import 'package:veterinary/src/shared/widgets/vet-combo.dart';

import '../providers/services/shared-preferences.dart';
import '../providers/services/client-service.dart';
import '../providers/models/client-model.dart';

import '../shared/widgets/vet-input.dart';
import '../shared/widgets/vet-button.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var clientData;
  @override
  void initState() {
    super.initState();
    clientData = _getClientData();
  }

  Future<dynamic> _getClientData() async {
    final token = await SharedPreferencesVet.getToken();
    final clientId = await SharedPreferencesVet.getClientId();
    final data = await ClientService.getClientData(token, clientId);

    return data;
  }

  Widget header({String name}) {
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
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
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
        child: FutureBuilder(
          future: clientData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              final Client data = snapshot.data;

              return data != null ? Column(
                children: <Widget>[
                  header(name: data.clientFullName),
                  SizedBox(height: 40.0),
                  ProfileForm(clientData: data)
                ]
              ) : Text('Error...');
            } else {
              return Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[350],
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 200.0)
              );
            }
          },
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
  bool _requiredCurrentPass = false;
  String _userName;
  String _userDocumentNumber;
  int _userDocumentId;
  String _userEmail;
  String _userAlias;
  String _userCurrentPass;
  String _userNewPass;
  String _userValidPass;

  void _showDialog({String description}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  description,
                  style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center
                ),
                SizedBox(height: 30.0),
                VetButton(
                  color: Color.fromRGBO(202, 57, 48, 1.0),
                  text: 'Aceptar',
                  textSize: 18.0,
                  onPress: () {
                    Navigator.pop(context);
                  }
                )
              ]
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          )
        );
      }
    );
  }

  void _updateDataClient() async {
    print(_userNewPass);
    print(_userValidPass);
    if (_userNewPass == _userValidPass) {
      print('valuee');
      final clientId = await SharedPreferencesVet.getClientId();
      final request = {
        "ClientId" : clientId,
        "ClientFullName" : _userName,
        "ClientDocumentNumber" : _userDocumentNumber,
        "ClientDocumentTypeId" : _userDocumentId,
        // "ClientCellPhoneNumber" : "5555555",
        // "ClientPhoneNumber" : "9999999",
        "ClientEmail" : _userEmail,
        // "ClientSexId" : 2
      };
      final response = await ClientService.updateClient(form: request);
      print(response);
    } else {
      _showDialog(description: 'Valida tu nueva contraseña correctamente');
    }
  }

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
          _updateDataClient();
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
              onSave: (val) => _userName = val,
              initValue: widget.clientData.clientFullName
            ),
            SizedBox(height: 20.0),
            VetCombo(
              initValue: widget.clientData.clientDocumentTypeId,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Tipo documento',
              lookupType: 'documents',
              onChange: (val) => _userDocumentId = val,
              onSave: (val) => _userDocumentId = val
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
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300], width: 1.0))),
              margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
              padding: EdgeInsets.only(top: 20.0),
              width: double.infinity
            ),
            VetInput(label: 'Actual', onSave: (val) => _userCurrentPass = val, inputType: 'password', required: _requiredCurrentPass),
            SizedBox(height: 20.0),
            VetInput(label: 'Nueva contraseña', onSave: (val) => _userNewPass = val, inputType: 'password', required: false),
            SizedBox(height: 20.0),
            VetInput(label: 'Repetir contraseña', onSave: (val) => _userValidPass = val, inputType: 'password', required: false),
            SizedBox(height: 40.0),
            btnForm()
          ],
        )
      )
    );
  }
}