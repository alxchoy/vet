import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              children: <Widget>[
                _loginBtn(context: context),
                SizedBox(height: 20),
                _registerBtn(context: context),
                SizedBox(height: 40),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
            )
          )
        ),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/img/background.png'), fit: BoxFit.cover)
        )
      )
    );
  }

  Widget _loginBtn({BuildContext context}) {
    return FlatButton(
      child: Container(
        child: Text(
          'Ingresar'.toUpperCase(),
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: <BoxShadow>[
            // BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6), offset: Offset(0.0, 10.0), blurRadius: 15.0)
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.5), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(90, 168, 158, 1.0),
              Color.fromRGBO(70, 136, 153, 1.0),
              Color.fromRGBO(55, 112, 150, 1.0),
            ]
          )
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0),
      ),
      color: Color.fromRGBO(0, 0, 0, 0.0),
      onPressed: () => Navigator.pushNamed(context, '/login'),
      padding: EdgeInsets.all(0.0),
    );
  }

  Widget _registerBtn({BuildContext context}) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      child: Text(
        'Registrar'.toUpperCase(),
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
      onPressed: () => Navigator.pushNamed(context, '/register'),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
    );
  }
}