import 'package:flutter/material.dart';

import '../providers/services/pet-service.dart';
import '../shared/widgets/vet-search-list.dart';

class ServicesScreen extends StatefulWidget {

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  bool _isLoaded = true;
  final inputController = TextEditingController();
  var listItems = [];

  @override
  void initState() {
    super.initState();
    _getServices();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  void _getServices() async {
    setState(() => _isLoaded = false);
    listItems = await PetService.getServices();
    setState(() => _isLoaded = true);
  }

  Widget _serviceRow({item}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      child: Row(
        children: <Widget>[
          Text(item['serviceDescription'], style: TextStyle(fontSize: 18.0)),
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)
    );
  }

  Widget _servicesRowList() {
    List<Widget> _listRow = [];

    for (var item in listItems) {
      _listRow.add(_serviceRow(item: item));
    }

    return Column(
      children: _listRow,
    );
  }


  Widget _searchInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.6), offset: Offset(0.0, 1.0), blurRadius: 5.0)
        ]
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, size: 30.0),
          border: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          hintText: 'Buscar',
          hintStyle: TextStyle(fontSize: 18.0)
        ),
        style: TextStyle(fontSize: 18.0),
        controller: inputController
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _isLoaded ? Column(
          children: <Widget>[
            _searchInput(),
            _servicesRowList()
          ]
        ) : Container(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[350],
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
            )
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0),
          margin: EdgeInsets.only(top: 80.0),
        )
      )
    );
  }
}