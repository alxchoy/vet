import 'package:flutter/material.dart';

class CardPet extends StatelessWidget {
  final petData;

  CardPet({this.petData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.lightBlue,
              image: DecorationImage(
                image: NetworkImage(petData['petPathImage']),
                fit: BoxFit.cover
              )
            )
          ),
          Padding(
            child: Column(
              children: <Widget>[
                Text(
                  petData['petName'],
                  style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700)
                ),
                Text(
                  "${petData['petAge']} ${petData['petAge'] != 1 ? 'años' : 'año'}",
                  style: TextStyle(color: Colors.black, fontSize: 18)
                )
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