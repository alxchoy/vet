import 'package:flutter/material.dart';

// import '../providers/services/client-service.dart';
import '../../shared/widgets/vet-input.dart';
import '../../utils/helpers.dart';
import './auth_header.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    AuthHeader(title: 'Regístrate'),
                    // RegisterForm()
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