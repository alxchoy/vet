import 'package:flutter/material.dart';

import '../providers/models/pet-model.dart';
import '../shared/widgets/vet-header.dart';
import '../shared/widgets/vet-add-list.dart';
import '../shared/widgets/vet-button.dart';


class FoodsVaccinesScreen extends StatelessWidget {
  final Pet pet;

  FoodsVaccinesScreen({this.pet});

  @override
  Widget build(BuildContext context) {
    print(pet.toJson());
    return Scaffold(
      appBar: AppBar(title: Text('Vacunas')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              VetHeader(pet: pet),
              VetAddList(
                label: 'Alimentación',
                lookupType: 'aliments',
                petId: pet.petId
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0)
              ),
              SizedBox(height: 10.0),
              VetAddList(
                label: 'Vacunas',
                lookupType: 'vaccines',
                petId: pet.petId
              ),
              SizedBox(height: 40.0),
              VetButton(
                color: Color.fromRGBO(90, 168, 158, 1.0),
                text: 'Finalizar',
                textSize: 24.0,
                onPress: () {
                  Navigator.pop(context);
                }
              )
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
        )
      )
    );
  }
}