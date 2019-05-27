import 'package:flutter/material.dart';

import '../providers/models/pet-model.dart';
import '../providers/services/pet-service.dart';
import '../shared/widgets/vet-header.dart';
import '../shared/widgets/vet-add-list.dart';
import '../shared/widgets/vet-button.dart';

class ReportScreen extends StatefulWidget {
  final Pet pet;

  ReportScreen({this.pet});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<dynamic> _listSymptoms;
  bool _isLoading = false;

  _getSymptomsList(list) {
    if (list.length > 0) {
      setState(() {
        _listSymptoms = list;
      });
    }
  }

  _getReportData() async {
    var listIds = [];

    if (_listSymptoms != null && _listSymptoms.isNotEmpty) {
      setState(() => _isLoading = true);
      for (var item in _listSymptoms) {
        listIds.add(item['symptomId']);
      }
    }

    if (listIds.isNotEmpty) {
      final response = await PetService.reportPet(widget.pet.petId, listIds);
      print(response);
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Reportar')),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    VetHeader(pet: widget.pet),
                    VetAddList(
                      label: 'Síntomas',
                      lookupType: 'symptoms',
                      petId: widget.pet.petId,
                      getSymptoms: _getSymptomsList
                    ),
                    SizedBox(height: 40.0),
                    VetButton(
                      color: Color.fromRGBO(202, 57, 48, 1.0),
                      text: 'Reportar',
                      textSize: 24.0,
                      onPress: _getReportData
                    )
                  ]
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: _isLoading ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[350],
                      valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
                    )
                  ),
                  color: Color.fromRGBO(0, 0, 0, 0.3)
                ): Container()
              )
            ]
          )
        )
      )
    );
  }
}