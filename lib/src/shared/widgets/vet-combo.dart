import 'dart:convert';

import 'package:flutter/material.dart';

import '../../providers/services/shared-preferences.dart';

class VetCombo extends StatefulWidget {
  final Icon icon;
  final String lookupType;
  final String label;
  final Map<String, String> keyProperties;

  VetCombo({this.icon, this.lookupType, this.label, this.keyProperties});

  @override
  _VetComboState createState() => _VetComboState();
}

class _VetComboState extends State<VetCombo> {
  List<dynamic> _lookupService;
  var _selectValue;

  @override
  void initState() {
    _loadLookup();
    super.initState();
  }

  void _loadLookup() async {
    final lookup = await SharedPreferencesVet.getLookups();
    final lookupDecode = json.decode(lookup);

    setState(() {
      _lookupService = lookupDecode[widget.lookupType];
      print(_lookupService);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: widget.icon ?? null,
            labelText: widget.label,
            labelStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: 18
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Colors.grey[350]),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0)
          ),
          child: _lookupService != null ? DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text('Seleccionar'),
              items: _lookupService.map((val) {
                return DropdownMenuItem(
                  value: val[widget.keyProperties['keyValue']],
                  child: Text(val[widget.keyProperties['keyDescription']])
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectValue = value;
                  state.didChange(value);
                });
              },
              value: _selectValue
            )
          ) : Container()
        );
      }
    );
  }
}
