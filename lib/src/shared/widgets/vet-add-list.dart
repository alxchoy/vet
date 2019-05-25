import 'dart:convert';

import 'package:flutter/material.dart';

import './vet-list.dart';

import '../../providers/services/shared-preferences.dart';
import '../../providers/services/pet-service.dart';
import '../../providers/models/food-pet-client-model.dart';


class VetAddList extends StatefulWidget {
  final String label;
  final String lookupType;
  final int petId;

  VetAddList({this.label, this.lookupType, this.petId});

  @override
  _VetAddListState createState() => _VetAddListState();
}

class _VetAddListState extends State<VetAddList> {
  List<FoodPetClient> _alimentsByPet;

  @override
  void initState() {
    super.initState();
    _setListAlimentations();
  }

  Future<List<dynamic>> _getListLookup() async {
    final lookups = await SharedPreferencesVet.getLookups();
    final lookupsDecode = json.decode(lookups);

    return lookupsDecode[widget.lookupType];
  }

  Future<void> _setListAlimentations() async {
    final response = widget.petId != null ? await PetService.getAlimentationsByPet(widget.petId) : [];
    List<FoodPetClient> _aliments = [];

    for (var item in response) {
      _aliments.add(item);
    }

    setState(() {
      _alimentsByPet = _aliments;
    });
  }

  Future<void> _deleteFood(petAlimentationId) async {
    final bool response = await PetService.deleteAlimentation(petAlimentationId);
    if (response) {
      setState(() {
        _alimentsByPet.removeWhere((item) => item.petAlimentationId == petAlimentationId);
      });
    }
  }

  Widget buttonInput() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 18
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey[350]),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0)
      ),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Seleccionar', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)),
            Icon(Icons.arrow_drop_down)
          ]
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VetList()));
        },
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      )
    );
  }

  Widget rowFood({FoodPetClient food}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${food.alimentationName}', style: TextStyle(fontSize: 18.0)),
          GestureDetector(
            child: Icon(Icons.delete, color: Colors.red, size: 25.0),
            onTap: () => _deleteFood(food.petAlimentationId)
          )
        ]
      ),
      padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)
    );
  }

  Widget _createFoodList(list) {
    List<Widget> _listWidget = [];

    for (var item in list) {
      _listWidget.add(rowFood(food: item));
    }

    return Column(
      children: _listWidget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(widget.label, style: TextStyle(fontSize: 22.0)),
          SizedBox(height: 20.0),
          buttonInput(),
          Container(
            child: _alimentsByPet != null ? _createFoodList(_alimentsByPet) : Center(child: CircularProgressIndicator())
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }
}