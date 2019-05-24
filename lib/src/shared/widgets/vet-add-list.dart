import 'dart:convert';

import 'package:flutter/material.dart';

import '../../providers/services/shared-preferences.dart';
import './vet-list.dart';

class VetAddList extends StatefulWidget {
  final String label;
  final String lookupType;

  VetAddList({this.label, this.lookupType});

  @override
  _VetAddListState createState() => _VetAddListState();
}

class _VetAddListState extends State<VetAddList> {

  Future<List<dynamic>> _getList() async {
    final lookups = await SharedPreferencesVet.getLookups();
    final lookupsDecode = json.decode(lookups);

    print(lookupsDecode[widget.lookupType]);

    return lookupsDecode[widget.lookupType];
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

  // Widget _createListView() {
  //   return ListView.builder();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(widget.label, style: TextStyle(fontSize: 22.0)),
          SizedBox(height: 20.0),
          buttonInput(),
          FutureBuilder(
            future: _getList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return snapshot.data != null ? Text('Holis') : Text('Pending...');
              } else {
                return Text('Error');
              }
            }
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }
}