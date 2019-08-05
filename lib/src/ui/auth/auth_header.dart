import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  AuthHeader({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          Padding(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold
              ),
            ),
            padding: EdgeInsets.only(left: 35.0),
          ),
          _subtitleWidget()
        ],
        crossAxisAlignment: CrossAxisAlignment.start
      )
    );
  }

  Widget _subtitleWidget() {
    if (subTitle != null) {
      return Padding(
        child: Text(
          subTitle,
          style: TextStyle(
            fontSize: 18.0
          ),
        ),
        padding: EdgeInsets.only(left: 35.0),
      );
    } else {
      return Container();
    }
  }
}