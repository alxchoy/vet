import 'package:flutter/material.dart';

import 'package:veterinary/src/widgets/vet_button.dart';

class Helpers {
  static showVetDialog({BuildContext context, String description, dynamic btnConfig}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  description,
                  style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center
                ),
                SizedBox(height: 30.0),
                VetButton(
                  color: btnConfig['color'],
                  text: btnConfig['text'],
                  textSize: 18.0,
                  onPress: btnConfig['action']
                )
              ]
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          )
        );
      }
    );
  }

  static showLoader({@required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)
            )
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        );
      }
    );
  }

  static dismissLoader({@required BuildContext context}) {
    Navigator.pop(context);
  }
}