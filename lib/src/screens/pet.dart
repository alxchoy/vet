import 'package:flutter/material.dart';

class PetScreen extends StatefulWidget {
  PetScreen({Key key}) : super(key: key);

  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  Widget petHeaderDetail({String lblTitle, String lblDetail}) {
    return Column(
      children: <Widget>[
        Text(lblTitle, style: TextStyle(fontSize: 18)),
        Text(lblDetail, style: TextStyle(fontSize: 22))
      ],
      crossAxisAlignment: CrossAxisAlignment.start
    );
  }

  Widget petHeader() {
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
            width: 150.0,
          ),
          Row(
            children: <Widget>[
              Container(
                child: petHeaderDetail(lblTitle: 'Nombre', lblDetail: 'Peluchin'),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300], width: 2.0))
                ),
                padding: EdgeInsets.only(right: 20.0)
              ),
              Container(
                child: petHeaderDetail(lblTitle: 'Edad', lblDetail: '3 años'),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300], width: 2.0))
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0)
              ),
              Container(
                child: petHeaderDetail(lblTitle: 'Raza', lblDetail: 'Boxer'),
                padding: EdgeInsets.only(left: 20.0)
              )
            ]
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              petHeader()
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
        )
      )
    );
  }
}