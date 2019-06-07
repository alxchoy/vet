import 'package:flutter/material.dart';

import '../providers/models/provider-model.dart';
import '../providers/services/provider-service.dart';

class ProviderScreen extends StatefulWidget {

  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  Provider provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProviderData();
  }

  getProviderData() async {
    provider = ModalRoute.of(context).settings.arguments;
    final response = await ProviderService.getProviderDetails(providerId: provider.providerId);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de la clínica', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: provider != null ? Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 5.0, color: Color.fromRGBO(0, 0, 0, 0.5), offset: Offset(1.0, 3.0))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(provider.pathImage)
                )
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
                  Text(provider.providerDocumentType, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5.0),
                  Text(provider.providerDocumentNumber, style: TextStyle(fontSize: 16))
                ]
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
              ),
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
              padding: EdgeInsets.only(bottom: 10.0)
            ),
            SedesList()
          ]
        ) : Container(),
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 30.0)
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