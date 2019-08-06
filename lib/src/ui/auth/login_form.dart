import 'package:flutter/material.dart';

import '../../shared/widgets/vet-input.dart';
import '../../bloc/bloc_provider.dart';
import '../../bloc/login_bloc.dart';
import '../../bloc/form_bloc.dart';

class LoginForm extends StatefulWidget {
  final Function navigate;

  LoginForm({this.navigate});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  LoginBloc _bloc;
  FormBloc _formBloc;
  bool _autovalidate = false;
  String _userName;
  String _userPassword;

  _LoginFormState();

  @override
  void didChangeDependencies() {
    _formBloc = BlocProvider.of<FormBloc>(context);
    _bloc = BlocProvider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  void _validateForm({BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _bloc.fetchToken(userName: _userName, password: _userPassword, context: context);
      widget.navigate();
    } else {
      setState(() => _autovalidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('FORM::: ${_formBloc.inputsStream}');
    return Form(
      autovalidate: _autovalidate,
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            VetInput(label: 'Usuario', inputProperty: 'userName'),
            SizedBox(height: 20.0,),
            // VetInput(label: 'Contraseña', onSave: (val) => _userPassword = val, inputType: 'password'),
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

