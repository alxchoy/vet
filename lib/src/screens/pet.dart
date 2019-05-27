import 'package:flutter/material.dart';

import '../providers/models/pet-model.dart';
import '../shared/widgets/vet-input.dart';
import '../shared/widgets/vet-combo.dart';
import '../shared/widgets/vet-date.dart';
import '../shared/widgets/vet-add-list.dart';
import '../shared/widgets/vet-header.dart';
import '../shared/widgets/vet-button.dart';
import '../shared/vet_app_icons.dart';

import './vaccines.dart';
import './report.dart';

class PetScreen extends StatefulWidget {

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
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
              VetHeader(pet: pet),
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
              icon: Icon(VetAppIcons.huella, size: 45.0),
              initValue: widget.pet != null ? widget.pet.petName : '',
              label: 'Nombre'
            ),
            SizedBox(height: 20.0),
            VetDate(icon: Icon(VetAppIcons.calendar, size: 45.0), label: 'Fecha de nacimiento'),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(VetAppIcons.specie, size: 45.0),
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
              icon: Icon(VetAppIcons.huella, size: 45.0),
              initValue: _specieId != null ? null : (widget.pet != null ? widget.pet.raceId : null),
              keyProperties: {
                'keyValue': 'raceId',
                'keyDescription': 'raceName'
              },
              label: 'Raza',
              lookupType: 'races',
              onChange: (val) => _raceId = val
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(VetAppIcons.sexo, size: 45.0),
              initValue: widget.pet != null ? widget.pet.sexId : null,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Sexo',
              lookupType: 'sex',
              onChange: (val) => _sexId = val
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(VetAppIcons.size, size: 45.0),
              initValue: widget.pet != null ? widget.pet.petSizeId : null,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Tamaño',
              lookupType: 'size',
              onChange: (val) => _sizeId = val
            ),
            SizedBox(height: 20.0),
            VetInput(
              icon: Icon(VetAppIcons.peso, size: 45.0),
              initValue: widget.pet != null ? widget.pet.petWeight.toStringAsFixed(2) : null,
              label: 'Peso'
            ),
            SizedBox(height: 20.0),
            VetCombo(
              icon: Icon(VetAppIcons.habitad, size: 45.0),
              initValue: widget.pet != null ? widget.pet.habitadId : null,
              keyProperties: {
                'keyValue': 'id',
                'keyDescription': 'description'
              },
              label: 'Habitat',
              lookupType: 'habitat',
              onChange: (val) => _habitatId = val
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0)
            ),
            VetAddList(
              label: 'Alimentación',
              lookupType: 'aliments',
              petId: widget.pet != null ? widget.pet.petId : null
            ),
            Container(
              child: Text('Vacunas', style: TextStyle(fontSize: 22.0)),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300], width: 1.0)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              padding: EdgeInsets.only(top: 20.0),
              width: double.infinity
            ),
            VetButton(
              color: Color.fromRGBO(90, 168, 158, 1.0),
              text: 'Ver todas las vacunas',
              textSize: 20.0,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VaccinesScreen(pet: widget.pet))
                );
              }
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0)
            ),
            SizedBox(height: 20.0),
            VetButton(
              color: Color.fromRGBO(202, 57, 48, 1.0),
              text: 'Reportar enfermedad',
              textSize: 24.0,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportScreen(pet: widget.pet))
                );
              }
            ),
            SizedBox(height: 20.0),
            VetButton(
              color: Color.fromRGBO(90, 168, 158, 1.0),
              text: 'Guardar',
              textSize: 24.0,
              onPress: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                } else {
                  setState(() => _autovalidate = true);
                }
              }
            )
          ]
        )
      )
    );
  }
}