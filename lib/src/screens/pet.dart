import 'package:flutter/material.dart';

import '../providers/models/pet-model.dart';
import '../shared/widgets/vet-input.dart';
import '../shared/widgets/vet-combo.dart';
import '../shared/widgets/vet-date.dart';
import '../shared/widgets/vet-add-list.dart';

class PetScreen extends StatefulWidget {

  @override
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
    final Pet pet = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet')
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              petHeader(),
              PetForm(pet: pet)
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
        )
      )
    );
  }
}

class PetForm extends StatefulWidget {
  final Pet pet;

  PetForm({this.pet});

  @override
  _PetFormState createState() => _PetFormState();
}

class _PetFormState extends State<PetForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  var _specieId;
  var _raceId;
  var _sexId;
  var _sizeId;
  var _habitatId;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('General', style: TextStyle(fontSize: 22.0)),
            SizedBox(height: 15.0),
            VetInput(
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.petName : '',
              label: 'Nombre'
            ),
            SizedBox(height: 20.0),
            VetDate(icon: Icon(Icons.account_box, size: 50.0), label: 'Fecha de nacimiento'),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.specieId : null,
              keyProperties: {
                'keyValue': 'specieId',
                'keyDescription': 'specieName'
              },
              label: 'Especie',
              lookupType: 'species',
              onChange: (val) => setState(() => _specieId = val)
            ),
            SizedBox(height: 20.0),
            VetCombo(
              dependingValue: _specieId ?? (widget.pet != null ? widget.pet.specieId : null),
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.raceId : null,
              keyProperties: {
                'keyValue': 'raceId',
                'keyDescription': 'raceName'
              },
              label: 'Raza',
              lookupType: 'races',
              onChange: (val) => setState(() => _raceId = val)
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.sexId : null,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Sexo',
              lookupType: 'sex',
              onChange: (val) => setState(() => _sexId = val)
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.petSizeId : null,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Tamaño',
              lookupType: 'size',
              onChange: (val) => setState(() => _sizeId = val)
            ),
            SizedBox(height: 20.0),
            VetInput(
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.petWeight.toStringAsFixed(2) : null,
              label: 'Peso'
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(Icons.account_box, size: 50.0),
              initValue: widget.pet != null ? widget.pet.habitadId : null,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Habitat',
              lookupType: 'habitat',
              onChange: (val) => setState(() => _habitatId = val)
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0)
            ),
            VetAddList(label: 'Alimentación', lookupType: 'aliments'),
            SizedBox(height: 40.0),
            btnForm()
          ]
        )
      )
    );
  }
}