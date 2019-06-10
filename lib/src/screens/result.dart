import 'package:flutter/material.dart';

import '../providers/models/disease-model.dart';
import '../providers/models/provider-model.dart';
import '../shared/vet_app_icons.dart';
import '../shared/widgets/vet-button.dart';
import './provider.dart';
import './map.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              DiseasesList(diseases: data['diseases']),
              ProvidersList(providers: data['providers']),
              Container(
                child: VetButton(
                  color: Color.fromRGBO(90, 168, 158, 1.0),
                  text: 'Ver mapa',
                  textSize: 22.0,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen(providers: data['providers']))
                    );
                  },
                ),
                margin: EdgeInsets.only(top: 40.0)
              )
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
        )
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

  @override
  Widget build(BuildContext context) {
    return _providersRowList(context: context, providers: providers);
  }

  Widget _providerTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Puede atenderlo', style: TextStyle(fontSize: 22.0)),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      padding: EdgeInsets.only(bottom: 10.0)
    );
  }

  Widget _providerDetail({Provider provider}) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(provider.pathImage),
                  fit: BoxFit.cover
                ),
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              height: 70.0,
              margin: EdgeInsets.only(right: 15.0)
            ),
            flex: 1
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Text(provider.providerName, style: TextStyle(fontSize: 18.0), overflow: TextOverflow.ellipsis),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Dirección', style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 3
                    ),
                    Expanded(
                      child:Text(provider.headqueaterAddress, overflow: TextOverflow.ellipsis),
                      flex: 3
                    )
                  ]
                ),
                SizedBox(height: 3.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Teléfono', style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 3
                    ),
                    Expanded(
                      child: Text(provider.headquaterPhone, overflow: TextOverflow.ellipsis),
                      flex: 3
                    )
                  ]
                ),
              ]
            ),
            flex: 2
          )
        ]
      ),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      padding: EdgeInsets.only(right: 10.0)
    );
  }

  Widget _providerRow({BuildContext context, Provider provider}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _providerDetail(provider: provider),
            flex: 4,
          ),
          Expanded(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProviderScreen(providerId: provider.providerId))
                );
              }
            ),
            flex: 1
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0)
    );
  }

  Widget _providersRowList({BuildContext context, List<Provider> providers}) {
    List<Widget> _listRow = [_providerTitle()];

    for (var provider in providers) {
      _listRow.add(_providerRow(context: context, provider: provider));
    }

    return Column(
      children: _listRow,
    );
  }
}