import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _loginBtn(context: context),
              SizedBox(height: 20),
              _registerBtn(context: context),
              SizedBox(height: 40),
            ]
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/img/background.png'), fit: BoxFit.cover)
        )
      )
    );
  }

  Widget _loginBtn({BuildContext context}) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Padding(
            child: Text(
              'INGRESAR',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0)
          ),
          onTap: () => Navigator.pushNamed(context, '/login'),
        )
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.5), blurRadius: 5.0)
        ],
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(90, 168, 158, 1.0),
            Color.fromRGBO(70, 136, 153, 1.0),
            Color.fromRGBO(55, 112, 150, 1.0),
          ]
        )
      )
    );
  }

  Widget _registerBtn({BuildContext context}) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      child: Text(
        'REGISTRAR',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      onPressed: () => Navigator.pushNamed(context, '/register'),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
    );
  }
}