import 'package:flutter/material.dart';

import '../vet_app_icons.dart';

class VetInfoList extends StatelessWidget {
  final String nameProperty;
  final String titlelist;
  final List<dynamic> listItems;

  VetInfoList({this.nameProperty, this.listItems, this.titlelist});

  Widget _rowItem({String name}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      child: Row(
        children: <Widget>[
          Text(name, style: TextStyle(fontSize: 18.0)),
          SizedBox(width: 20.0),
          Icon(VetAppIcons.info, size: 20.0)
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0)
    );
  }

  List<Widget> _mapListItem({String title}) {
    List<Widget> listWidgets = [];

    for (var item in listItems) {
      listWidgets.add(_rowItem(name: item[nameProperty]));
    }

    return listWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _mapListItem(title: titlelist)
      )
    );
  }
}