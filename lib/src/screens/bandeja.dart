import 'package:flutter/material.dart';

import '../providers/services/pet-service.dart';
import '../providers/services/shared-preferences.dart';
import '../providers/models/pet-model.dart';

class BandejaScreen extends StatefulWidget {
  @override
  _BandejaScreenState createState() => _BandejaScreenState();
}

class _BandejaScreenState extends State<BandejaScreen> {

  Future<dynamic> _getPetsList() async {
    final clientId = await SharedPreferencesVet.getClientId();
    final pets = await PetService.getPetsList(clientId);

    return pets;
  }

  OutlineButton _addPetBtn() {
    return OutlineButton(
      borderSide: BorderSide(color: Color.fromRGBO(159, 189, 184, 1.0), width: 2.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.add_circle_outline, color: Color.fromRGBO(90, 168, 158, 1.0), size: 30),
          SizedBox(width: 5),
          Text(
            'Agregar mascota',
            style: TextStyle(color: Color.fromRGBO(90, 168, 158, 1.0), fontSize: 18)
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/pet');
      },
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
    );
  }

  Widget _createPetsGridView(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: CardPet(pet: snapshot.data[index]),
          onTap: () {
            Navigator.pushNamed(context, '/pet', arguments: snapshot.data[index]);
          }
        );
      },
      itemCount: snapshot.data.length,
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: _addPetBtn(),
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getPetsList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  return snapshot.data != null ? _createPetsGridView(context, snapshot) : Text('Pending...');
                } else {
                  return Text('Error');
                }
              }
            )
          )
        ]
      )
    );
  }
}

class CardPet extends StatefulWidget {
  final Pet pet;

  CardPet({this.pet});

  @override
  _CardPetState createState() => _CardPetState();
}

class _CardPetState extends State<CardPet> {
  bool _loadImage = false;

  @override
  void initState() {
    super.initState();
    // Image.network(widget.pet.petPathImage).image.resolve(ImageConfiguration()).addListener((a, b) {
    //   if (mounted) {
    //     setState(() => _loadImage = true);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // _loadImage ? Image.network(widget.pet.petPathImage) : AssetImage('assets/img/background.png'),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.lightBlue
            )
          ),
          Padding(
            child: Column(
              children: <Widget>[
                Text(
                  widget.pet.petName,
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)
                ),
                Text(
                  "${widget.pet.petAge} ${widget.pet.petAge != 1 ? 'años' : 'año'}",
                  style: TextStyle(color: Colors.white, fontSize: 18)
                ),
                Text('${widget.pet.petPathImage}')
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            padding: EdgeInsets.all(10.0),
          )
        ]
      )
    );
  }
}