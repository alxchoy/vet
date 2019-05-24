import 'package:flutter/material.dart';

class VetList extends StatefulWidget {
  @override
  _VetListState createState() => _VetListState();
}

class _VetListState extends State<VetList> {
  final _controller = TextEditingController();

  TextField searchInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar',
        icon: Icon(Icons.search)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(

        )
      )
    );
  }
}