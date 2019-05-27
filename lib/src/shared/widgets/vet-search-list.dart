import 'package:flutter/material.dart';

class VetListSearch extends SearchDelegate {
  final List<dynamic> list;
  final String propertyName;

  VetListSearch({this.list, this.propertyName});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.search), onPressed: () {})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? list : list.where((item) => item[propertyName].contains(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            child: Text("${suggestionList[index][propertyName]}", style: TextStyle(fontSize: 15.0)),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[350], width: 1.0))
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)
          ),
          onTap: () {
            close(context, suggestionList[index]);
          }
        );
      },
      itemCount: suggestionList.length
    );
  }
}