import 'package:flutter/material.dart';

import '../providers/models/provider-model.dart';

class ProviderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Provider provider = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de la clínica', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 5.0, color: Color.fromRGBO(0, 0, 0, 0.5), offset: Offset(1.0, 3.0))
                ],
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: widget.pet != null ? NetworkImage(widget.pet.petPathImage) : AssetImage('assets/img/addPhoto.png')
                // )
              ),
              height: 150.0,
              margin: EdgeInsets.only(bottom: 30.0),
              width: 150.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('RUC'),
                  SizedBox(height: 5.0),
                  Text('12345678912')
                ]
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
              ),
              padding: EdgeInsets.only(bottom: 10.0)
            ),
            SedesList()
          ]
        ),
      )
    );
  }
}

class SedesList extends StatelessWidget {
  final list = [1,2,3,4];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Text('PRUEba'),
            padding: EdgeInsets.all(20.0),
            width: 200.0,
            margin: EdgeInsets.only(right: 15.0),
          ),
          Container(
            color: Colors.red,
            child: Text('PRUEba'),
            padding: EdgeInsets.all(20.0),
            width: 200.0,
            margin: EdgeInsets.only(right: 15.0),
          ),
          Container(
            color: Colors.red,
            child: Text('PRUEba'),
            padding: EdgeInsets.all(20.0),
            width: 200.0,
            margin: EdgeInsets.only(right: 15.0),
          )
        ],
      ),
      height: 100.0,
    );
    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context, index) {
    //     return GestureDetector(
    //       child: Container(
    //         child: Text('Prueba'),
    //         decoration: BoxDecoration(
    //           border: Border(bottom: BorderSide(color: Colors.grey[350], width: 1.0))
    //         ),
    //         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)
    //       ),
    //       onTap: () {
    //         print('prueba');
    //       }
    //     );
    //   },
    //   itemCount: list.length
    // );
  }
}