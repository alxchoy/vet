import 'package:flutter/material.dart';

import '../providers/models/disease-model.dart';
import '../providers/models/provider-model.dart';
import '../shared/vet_app_icons.dart';

class ResultScreen extends StatefulWidget {

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Disease> diseases;
  List<Provider> providers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Posibles enfermedades'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            DiseasesList(diseases: data['diseases']),
            ProvidersList(providers: data['providers'])
          ]
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
      )
    );
  }
}

class DiseasesList extends StatelessWidget {
  final List<Disease> diseases;

  DiseasesList({this.diseases});

  Widget _diseaseRow({Disease disease}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      child: Row(
        children: <Widget>[
          Text(disease.diseaseName, style: TextStyle(fontSize: 18.0)),
          SizedBox(width: 20.0),
          Icon(VetAppIcons.info, size: 20.0)
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0)
    );
  }

  Widget _diseasesRowList({List<Disease> diseases}) {
    List<Widget> _listRow = [];

    for (var disease in diseases) {
      _listRow.add(_diseaseRow(disease: disease));
    }

    return Column(
      children: _listRow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _diseasesRowList(diseases: diseases);
  }
}

class ProvidersList extends StatelessWidget {
  final List<Provider> providers;

  ProvidersList({this.providers});

  Widget _providerDetail({Provider provider}) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: NetworkImage(provider.pathImage),
              //   fit: BoxFit.cover
              // ),
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            height: 70.0,
            margin: EdgeInsets.only(right: 15.0),
            width: 70.0
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(provider.providerName, style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis),
                width: 200.0,
              ),
              SizedBox(height: 5.0),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Dirección', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 20.0),
                    Container(
                      child: Text(provider.headqueaterAddress, overflow: TextOverflow.ellipsis),
                      width: 120.0,
                    )
                  ]
                ),
                // width: 250.0,
              ),
              SizedBox(height: 3.0),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Teléfono', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 24.0),
                    Text(provider.headquaterPhone, overflow: TextOverflow.ellipsis)
                  ]
                ),
                width: 200.0,
              ),
            ]
          )
        ]
      ),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      padding: EdgeInsets.only(right: 10.0)
    );
  }

  Widget _providerRow({Provider provider}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _providerDetail(provider: provider),
          Flexible(
            child: GestureDetector(
              child: Container(
                child: Text(
                  'Ver detalle',
                  style: TextStyle(fontSize: 18.0, color: Color.fromRGBO(90, 168, 158, 1.0)),
                  textAlign: TextAlign.center
                ),
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0)
              ),
              onTap: () {
                print('tab detalle');
              }
            )
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0)
    );
  }

  Widget _providersRowList({List<Provider> providers}) {
    List<Widget> _listRow = [];

    for (var provider in providers) {
      _listRow.add(_providerRow(provider: provider));
    }

    return Column(
      children: _listRow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _providersRowList(providers: providers);
  }
}