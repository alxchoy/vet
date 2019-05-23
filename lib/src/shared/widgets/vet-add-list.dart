import 'package:flutter/material.dart';

class VetAddList extends StatefulWidget {
  final String label;

  VetAddList({this.label});

  @override
  _VetAddListState createState() => _VetAddListState();
}

class _VetAddListState extends State<VetAddList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(widget.label, style: TextStyle(fontSize: 22.0)),
          SizedBox(height: 20.0),
          InputDecorator(
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
                print('tab tab tab');
              },
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),

            )
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }
}