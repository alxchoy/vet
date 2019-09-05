import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:veterinary/src/services/shared_preferences.dart';
import 'package:veterinary/src/utils/constants.dart';

class VetCombo extends StatefulWidget {
  final Icon icon;
  final String lookupType;
  final String label;
  final Map<String, String> keyProperties;
  final dynamic onChange;
  final dynamic onSave;
  final dynamic dependingValue;
  final dynamic initValue;

  VetCombo({
    this.icon,
    this.lookupType,
    this.label,
    this.keyProperties,
    this.onChange,
    this.onSave,
    this.dependingValue,
    this.initValue
  });

  @override
  _VetComboState createState() => _VetComboState();
}

class _VetComboState extends State<VetCombo> {
  List<dynamic> _lookupService;
  var _selectValue;

  @override
  void initState() {
    _loadLookup();
    _selectValue = widget.initValue;
    super.initState();
  }

  @override
  void didUpdateWidget(VetCombo oldWidget) {
    if (oldWidget.dependingValue != widget.dependingValue) {
      _loadLookup();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadLookup() async {
    var lookup;
    var lookupDecode;

    if (widget.lookupType == 'races' && widget.dependingValue != null) {
      lookup = await http.get("${constants['urlApi']}/maintenance/race/search?specieId=${widget.dependingValue}&filter");
      lookupDecode = json.decode(lookup.body);

      setState(() {
        _lookupService = lookupDecode;
        _selectValue = widget.initValue ?? null;
      });
    } else {
      lookup = await SharedPreferencesVet.getLookups();
      lookupDecode = json.decode(lookup);

      setState(() {
        _lookupService = lookupDecode[widget.lookupType];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: widget.icon ?? null,
            labelText: widget.label,
            errorText: state.hasError ? state.errorText : null,
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
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0)
          ),
          child: _lookupService != null ? DropdownButtonHideUnderline(
            child: DropdownButton(
              style: TextStyle(color: Colors.grey[900], fontSize: 18.0),
              hint: Text('Seleccionar'),
              isExpanded: true,
              items: _lookupService.map((val) {
                return DropdownMenuItem(
                  value: val[widget.keyProperties['keyValue']],
                  child: Text(val[widget.keyProperties['keyDescription']], maxLines: 1, overflow: TextOverflow.ellipsis)
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectValue = value;
                  state.didChange(value); // update FormField
                });
                widget.onChange(value);
              },
              value: _selectValue
            )
          ) : Container(
            child: Text('Seleccionar', style: TextStyle(fontSize: 18.0, color: Colors.grey[600])),
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0)
          )
        );
      },
      onSaved: (val) {
        widget.onSave(_selectValue);
      },
      validator: (val) {
        var value = val ?? _selectValue;
        return value == null ? 'Selecciona una opción' : null;
      }
    );
  }
}
