import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/models/pet-model.dart';

class VetHeader extends StatefulWidget {
  final Pet pet;

  VetHeader({this.pet});

  @override
  _VetHeaderState createState() => _VetHeaderState();
}

class _VetHeaderState extends State<VetHeader> {
  File _image;

  Future<void> _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    print(image);
  }

  Widget petHeaderDetail({String lblTitle, String lblDetail}) {
    return Column(
      children: <Widget>[
        Text(lblTitle, style: TextStyle(fontSize: 15)),
        SizedBox(height: 3.0),
        Text(lblDetail, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22))
      ],
      crossAxisAlignment: CrossAxisAlignment.start
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width - 40;

    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 5.0, color: Color.fromRGBO(0, 0, 0, 0.5), offset: Offset(1.0, 3.0))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: widget.pet != null ?
                    NetworkImage(widget.pet.petPathImage) :
                    AssetImage('assets/img/addPhoto.png'),
                  fit: widget.pet != null ? BoxFit.cover : BoxFit.none
                )
              ),
              height: 150.0,
              margin: EdgeInsets.only(bottom: 30.0),
              width: 150.0,
            ),
            onTap: _getImage
          ),
          Row(
            children: <Widget>[
              Container(
                child: petHeaderDetail(
                  lblTitle: 'Nombre',
                  lblDetail: widget.pet != null ? widget.pet.petName : 'Nombre'
                ),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
                ),
                padding: EdgeInsets.only(right: 20.0),
                width: widthScreen / 3
              ),
              Container(
                child: petHeaderDetail(
                  lblTitle: 'Edad',
                  lblDetail: widget.pet != null ? '${widget.pet.petAge} años' : 'Edad'
                ),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                width: widthScreen / 3
              ),
              Container(
                child: petHeaderDetail(
                  lblTitle: 'Raza',
                  lblDetail: widget.pet != null ? widget.pet.raceName: 'Raza'
                ),
                padding: EdgeInsets.only(left: 20.0),
                width: widthScreen / 3
              )
            ]
          )
        ]
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))
      ),
      padding: EdgeInsets.only(bottom: 15.0),
      margin: EdgeInsets.only(bottom: 30.0)
    );
  }
}