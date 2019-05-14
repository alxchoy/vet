import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            alignment: Alignment.centerRight,
            child: Padding(
              child: Column(
                children: <Widget>[
                  Text(
                    'Olvidaste tu contraseña?'
                  ),
                  SizedBox(height: 15.0,),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {},
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              padding: EdgeInsets.only(right: 35.0),
            )
          )
        ],
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

  final userInput = TextFormField(
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
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(27),
        borderSide: BorderSide(color: Colors.grey[350]),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0)
    ),
  );

  final passInput = TextFormField(
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
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(27.0),
        borderSide: BorderSide(color: Colors.grey[350]),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0)
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            userInput,
            SizedBox(height: 20.0,),
            passInput
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      )
    );
  }
}