import 'package:flutter/material.dart';


class VetInput extends StatelessWidget {
  final String label;
  final String initValue;
  final String inputType;
  final Icon icon;
  final Function onSave;

  const VetInput({
    Key key,
    this.label,
    this.initValue,
    this.inputType,
    this.icon,
    this.onSave
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 18
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey[350]),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27.0),
          borderSide: BorderSide(color: Colors.grey[350]),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0)
      ),
      style: TextStyle(fontSize: 18.0),
      initialValue: initValue,
      obscureText: inputType == 'password',
      onSaved: onSave,
      validator: (val) {
        String txt;
        if (val.isEmpty) {
          txt = 'Campo requerido';
        }

        return txt;
      }
    );
  }
}