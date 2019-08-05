import 'package:flutter/material.dart';

import '../providers/services/provider-service.dart';
import '../shared/widgets/vet-info-list.dart';
import '../shared/vet_app_icons.dart';

class ProviderScreen extends StatefulWidget {
  final providerId;

  ProviderScreen({this.providerId});

  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  var providerData;
  List<dynamic> specialties = [];
  List<dynamic> services = [];
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    getProviderData();
  }

  getProviderData() async {
    final response = await ProviderService.getProviderDetails(providerId: widget.providerId);
    setState(() {
      providerData = response;
    });
  }

  getListItems(value) {
    setState(() {
      specialties = value['specialties'];
      services = value['services'];
      products = value['products'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          providerData != null ? providerData['providerName'] : '',
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
      ),
      body: SingleChildScrollView(
        child: providerData != null ? Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 5.0, color: Color.fromRGBO(0, 0, 0, 0.5), offset: Offset(1.0, 3.0))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(providerData['providerImageUrl'])
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
                  Text(providerData['providerDocumentType'], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5.0),
                  Text(providerData['providerDocumentNumber'], style: TextStyle(fontSize: 16))
                ]
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
              ),
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
              padding: EdgeInsets.only(bottom: 10.0)
            ),
            SedesList(callback: getListItems, list: providerData['headquaters']),
            Container(
              child: specialties.isNotEmpty ? VetInfoList(
                titlelist: 'Especialidades',
                nameProperty: 'specialtyName',
                listItems: specialties,
              ) : null,
              padding: EdgeInsets.only(right: 20.0)
            ),
            Container(
              child: products.isNotEmpty ? VetInfoList(
                titlelist: 'Productos',
                nameProperty: 'productName',
                listItems: products,
              ) : null,
              padding: EdgeInsets.only(right: 20.0)
            ),
            Container(
              child: services.isNotEmpty ? VetInfoList(
                titlelist: 'Servicios',
                nameProperty: 'serviceName',
                listItems: services,
              ) : null,
              padding: EdgeInsets.only(right: 20.0)
            )
          ]
        ) : Container(),
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 30.0)
      )
    );
  }
}

class SedesList extends StatefulWidget {
  final list;
  final callback;

  SedesList({this.callback, this.list});

  @override
  _SedesListState createState() => _SedesListState();
}

class _SedesListState extends State<SedesList> {
  var sedeSelected;

  _getSedeData(value) {
    widget.callback(value['list']);
    setState(() {
      sedeSelected = value['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CardSede(
            callback: _getSedeData,
            sede: widget.list[index],
            selected: sedeSelected == widget.list[index]['providerHeadquartersId']
          );
        },
        itemCount: widget.list.length,
      ),
      height: 120.0,
    );
  }
}

class CardSede extends StatefulWidget {
  final sede;
  final callback;
  final selected;

  CardSede({this.callback, this.sede, this.selected});

  @override
  _CardSedeState createState() => _CardSedeState();
}

class _CardSedeState extends State<CardSede> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: widget.selected ? Color.fromRGBO(90, 168, 158, 1.0) : Colors.white,
        elevation: 2.0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  widget.sede['providerHeadquartersDescription'],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: widget.selected ? Colors.white : Colors.black),
                  overflow: TextOverflow.ellipsis
                )
              ),
              SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Icon(Icons.my_location, size: 18.0, color: widget.selected ? Colors.white : Colors.black),
                  SizedBox(width: 5.0),
                  Flexible(
                    child: Text(
                      widget.sede['providerHeadquartersAddress'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: widget.selected ? Colors.white : Colors.black)
                    )
                  )
                ]
              ),
              SizedBox(height: 3.0),
              Row(
                children: <Widget>[
                  Icon(VetAppIcons.call, size: 18.0, color: widget.selected ? Colors.white : Colors.black),
                  SizedBox(width: 5.0),
                  Text(
                    widget.sede['providerHeadquartersPhone'],
                    style: TextStyle(color: widget.selected ? Colors.white : Colors.black)
                  )
                ]
              ),
              SizedBox(height: 3.0),
              Row(
                children: <Widget>[
                  Icon(VetAppIcons.email, size: 18.0, color: widget.selected ? Colors.white : Colors.black),
                  SizedBox(width: 5.0),
                  Text(
                    widget.sede['providerHeadquartersEmail'],
                    style: TextStyle(color: widget.selected ? Colors.white : Colors.black)
                  )
                ]
              ),
            ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          width: 300.0,
        )
      ),
      onTap: () {
        widget.callback(
          {
            'list': {
              'specialties': widget.sede['specialties'],
              'products': widget.sede['products'],
              'services': widget.sede['services']
            },
            'id': widget.sede['providerHeadquartersId']
          }
        );
      }
    );
  }
}