import 'dart:convert';

import 'package:flutter/material.dart';

import './vet-search-list.dart';

import '../../providers/services/shared-preferences.dart';
import '../../providers/services/pet-service.dart';
import '../vet_app_icons.dart';


class VetAddList extends StatefulWidget {
  final String label;
  final String lookupType;
  final int petId;
  final dynamic getSymptoms;

  VetAddList({this.label, this.lookupType, this.petId, this.getSymptoms});

  @override
  _VetAddListState createState() => _VetAddListState();
}

class _VetAddListState extends State<VetAddList> {
  List<dynamic> _listRow;
  List<dynamic> _listSymptoms = [];
  List<dynamic> _lookupCurrentList;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _setListRow();
    _getListLookup();
  }

  Future<void> _getListLookup() async {
    final lookups = await SharedPreferencesVet.getLookups();
    final lookupsDecode = json.decode(lookups);
    _lookupCurrentList = lookupsDecode[widget.lookupType];
  }

  Future<void> _setListRow() async {
    setState(() => _loading = true);
    var response;

    if (widget.lookupType == 'aliments' && widget.petId != null) {
      response = await PetService.getAlimentationsByPet(widget.petId);
    } else if (widget.lookupType == 'vaccines' && widget.petId != null) {
      response = await PetService.getVaccinesByPet(widget.petId);
    } else if (widget.lookupType == 'symptoms') {
      widget.getSymptoms(_listSymptoms);
      response = _listSymptoms;
    } else {
      response = [];
    }

    setState(() {
      _listRow = response;
      _loading = false;
    });
  }

  Future<void> _deleteRow(item) async {
    if (widget.lookupType == 'aliments') {
      await PetService.deleteAlimentation(item['petAlimentationId']);
    } else if (widget.lookupType == 'vaccines') {
      await PetService.deleteVaccine(item['petVaccineId']);
    } else if (widget.lookupType == 'symptoms') {
      _listSymptoms.removeWhere((sympton) => sympton['symptomId'] == item['symptomId']);
    }

    await _setListRow();
  }

  Future<void> _getSelectedItem() async {
    var propertyName;
    if (widget.lookupType == 'aliments') {
      propertyName = 'alimentationName';
    } else if (widget.lookupType == 'vaccines') {
      propertyName = 'vaccineName';
    } else if (widget.lookupType == 'symptoms') {
      propertyName = 'symptomDescription';
    }

    final item = await showSearch(
      context: context,
      delegate: VetListSearch(
        list: _lookupCurrentList,
        propertyName: propertyName
      )
    );

    if (widget.lookupType == 'aliments' && item != null) {
      await PetService.addAlimentation(widget.petId, item['alimentationId']);
    } else if (widget.lookupType == 'vaccines' && item != null) {
      await PetService.addVaccine(widget.petId, item['vaccineId']);
    } else if (widget.lookupType == 'symptoms' && item != null) {
      _listSymptoms.add(item);
    }

    if (item != null) {
      await _setListRow();
    }
  }

  Widget selectButton(BuildContext context) {
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
          _getSelectedItem();
        },
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0)
      )
    );
  }

  Widget _rowItem({item}) {
    var propertyName;
    if (widget.lookupType == 'aliments') {
      propertyName = 'alimentationName';
    } else if (widget.lookupType == 'vaccines') {
      propertyName = 'vaccineName';
    } else if (widget.lookupType == 'symptoms') {
      propertyName = 'symptomDescription';
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text("${item[propertyName]}", style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis),
            width: 280.0,
          ),
          GestureDetector(
            child: Icon(VetAppIcons.trash, color: Color.fromRGBO(202, 57, 48, 1.0), size: 35.0),
            onTap: () {
              _deleteRow(item);
            }
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
    );
  }

  Widget _createList(list) {
    List<Widget> _listWidget = [];

    for (var item in list) {
      _listWidget.add(_rowItem(item: item));
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
          selectButton(context),
          Container(
            child: _loading == false ? _createList(_listRow) : Container(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[350],
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.0)
            )
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }
}