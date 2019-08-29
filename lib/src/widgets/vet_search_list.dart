import 'package:flutter/material.dart';

class VetListSearch extends SearchDelegate {
  final List<dynamic> list;
  final String propertyName;
  final bool back;

  VetListSearch({this.list, this.propertyName, this.back = true});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return this.back ? null : Icon(Icons.search);
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