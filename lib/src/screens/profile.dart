import 'package:flutter/material.dart';

import '../providers/services/shared-preferences.dart';
import '../providers/services/client-service.dart';
import '../providers/models/client-model.dart';

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
                  print(snapshot.data);
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
  static Client _clientData;
  static String _userName;
  static String _userDocumentNumber;
  static String _userEmail;
  static String _userAlias;
  static String _userCurrentPass;
  static String _userNewPass;
  static String _userValidPass;

  @override
  void initState() {
    super.initState();
    _clientData = widget.clientData;
  }

  Map<String, dynamic> _userNameInput = {
    'initialValue': _clientData.clientFullName,
    'label': 'Nombre',
    'onSave': (val) => _userName = val,
    'obscureText': false,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _userDocumentNumberInput = {
    'initialValue': _clientData.clientDocumentNumber,
    'label': 'Nro. documento',
    'onSave': (val) => _userDocumentNumber = val,
    'obscureText': false,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _userEmailInput = {
    'initialValue': _clientData.clientEmail,
    'label': 'Correo',
    'onSave': (val) => _userEmail = val,
    'obscureText': false,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _userAliasInput = {
    'initialValue': _clientData.userName,
    'label': 'Usuario',
    'onSave': (val) => _userAlias = val,
    'obscureText': false,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _userCurrentPassInput = {
    'label': 'Actual',
    'onSave': (val) => _userCurrentPass = val,
    'obscureText': true,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _userNewPassInput = {
    'label': 'Nueva contraseña',
    'onSave': (val) => _userNewPass = val,
    'obscureText': true,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

  Map<String, dynamic> _userValidPassInput = {
    'label': 'Repetir contraseña',
    'onSave': (val) => _userValidPass = val,
    'obscureText': true,
    'validator': (val) {
      if (val.isEmpty) {
        return 'Campo requerido';
      }
    }
  };

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
      initialValue: inputConfig['initialValue'],
      obscureText: inputConfig['obscureText'],
      onSaved: inputConfig['onSave'],
      validator: inputConfig['validator']
    );
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
      onPressed: () => Navigator.pushNamed(context, '/login'),
      padding: EdgeInsets.all(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            inputForm(_userNameInput),
            SizedBox(height: 20.0),
            inputForm(_userDocumentNumberInput),
            SizedBox(height: 20.0),
            inputForm(_userEmailInput),
            SizedBox(height: 20.0),
            inputForm(_userAliasInput),
            Container(
              child: Text('Contraseña', style: TextStyle(fontSize: 22.0)),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300], width: 2.0))),
              margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
              padding: EdgeInsets.only(top: 20.0),
              width: double.infinity
            ),
            inputForm(_userCurrentPassInput),
            SizedBox(height: 20.0),
            inputForm(_userNewPassInput),
            SizedBox(height: 20.0),
            inputForm(_userValidPassInput),
            SizedBox(height: 40.0),
            btnForm()
          ],
        )
      )
    );
  }
}