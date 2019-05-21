import 'package:flutter/material.dart';

import '../shared/widgets/vet-input.dart';

class PetScreen extends StatefulWidget {
  PetScreen({Key key}) : super(key: key);

  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  Widget petHeaderDetail({String lblTitle, String lblDetail}) {
    return Column(
      children: <Widget>[
        Text(lblTitle, style: TextStyle(fontSize: 15)),
        SizedBox(height: 3.0),
        Text(lblDetail, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22))
      ],
      crossAxisAlignment: CrossAxisAlignment.start
    );
  }

  Widget petHeader() {
    double widthScreen = MediaQuery.of(context).size.width - 40;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: NetworkImage()
              // ),
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            height: 150.0,
            margin: EdgeInsets.only(bottom: 30.0),
            width: 150.0,
          ),
          Row(
            children: <Widget>[
              Container(
                child: petHeaderDetail(lblTitle: 'Nombre', lblDetail: 'Peluchin'),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
                ),
                padding: EdgeInsets.only(right: 20.0),
                width: widthScreen / 3
              ),
              Container(
                child: petHeaderDetail(lblTitle: 'Edad', lblDetail: '3 años'),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: widthScreen / 3
              ),
              Container(
                child: petHeaderDetail(lblTitle: 'Raza', lblDetail: 'Perro peruano'),
                padding: EdgeInsets.only(left: 20.0),
                width: widthScreen / 3
              )
            ]
          )
        ]
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      padding: EdgeInsets.only(bottom: 15.0),
      margin: EdgeInsets.only(bottom: 30.0)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              petHeader(),
              PetForm()
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
        )
      )
    );
  }
}

class PetForm extends StatefulWidget {
  @override
  _PetFormState createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('General', style: TextStyle(fontSize: 22.0)),
          SizedBox(height: 15.0),
          VetInput(label: 'Nombre', initValue: ''),
        ]
      )
    );
  }
}