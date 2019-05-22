import 'package:flutter/material.dart';

import '../shared/widgets/vet-input.dart';
import '../shared/widgets/vet-combo.dart';

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
      appBar: AppBar(
        title: Text('Pet')
      ),
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
  final _formKey = GlobalKey<FormState>();
  int _specieId;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('General', style: TextStyle(fontSize: 22.0)),
            SizedBox(height: 15.0),
            VetInput(label: 'Nombre', icon: Icon(Icons.account_box, size: 50.0)),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              label: 'Especie',
              lookupType: 'species',
              keyProperties: {
                'keyValue': 'specieId',
                'keyDescription': 'specieName'
              },
              onChange: (val) {
                print(val);

                setState(() {
                  _specieId = val;
                });
              },
            ),
            SizedBox(height: 20.0),
            VetCombo(
              dependingValue: _specieId,
              icon: Icon(Icons.account_box, size: 50.0),
              keyProperties: {
                'keyValue': 'raceId',
                'keyDescription': 'raceName'
              },
              label: 'Raza',
              lookupType: 'races'
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              label: 'Sexo',
              lookupType: 'sex',
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              }
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              label: 'Tamaño',
              lookupType: 'size',
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              }
            ),
            SizedBox(height: 20.0),
            VetInput(label: 'Peso', icon: Icon(Icons.account_box, size: 50.0)),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              label: 'Habitat',
              lookupType: 'habitat',
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              }
            )
          ]
        )
      )
    );
  }
}