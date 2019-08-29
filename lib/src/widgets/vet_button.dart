import 'package:flutter/material.dart';

class VetButton extends StatelessWidget {
  final String text;
  final double textSize;
  final Color color;
  final dynamic onPress;

  VetButton({this.text, this.textSize, this.color, this.onPress});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        child: Center(
          child: Text(
            '${text.toUpperCase()}',
            style: TextStyle(fontSize: textSize, color: Colors.white),
          )
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.5), blurRadius: 5.0)
          ],
          color: color //Color.fromRGBO(90, 168, 158, 1.0)
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
        width: double.infinity,
      ),
      color: Color.fromRGBO(0, 0, 0, 0.0),
      onPressed: onPress,
      padding: EdgeInsets.all(0.0),
    );
  }
}