import 'package:flutter/material.dart';

class VetInput extends StatefulWidget {
  final String label;
  final String initValue;
  final String inputType;
  final Icon icon;
  final String validationType;
  final dynamic onSave;

  VetInput({this.label, this.initValue, this.validationType, this.onSave, this.inputType, this.icon});


  @override
  _VetInputState createState() => _VetInputState();
}

class _VetInputState extends State<VetInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: widget.icon ?? null,
        labelText: widget.label,
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
      initialValue: widget.initValue,
      obscureText: widget.inputType == 'password',
      onSaved: widget.onSave,
      validator: (val) {
        if (val.isEmpty) {
          return 'Campo requerido';
        }
      }
    );
  }
}