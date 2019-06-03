import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VetDate extends StatefulWidget {
  final Icon icon;
  final String label;
  final String initValue;
  final dynamic onChange;

  VetDate({this.icon, this.label, this.initValue, this.onChange});

  @override
  _VetDateState createState() => _VetDateState();
}

class _VetDateState extends State<VetDate> {
  static final _formatDate = DateFormat('dd-MM-yyyy');
  var _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initValue != null ?
      _formatDate.format(DateTime.parse(widget.initValue)) :
      _formatDate.format(DateTime.now());

    widget.onChange(_currentDate);
  }

  Future<void> _datePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _formatDate.parse(_currentDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050)
    );

    if(date != null) {
      setState(() => _currentDate = _formatDate.format(date));
      widget.onChange(_currentDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return GestureDetector(
          child: InputDecorator(
            decoration: InputDecoration(
              icon: widget.icon ?? null,
              labelText: widget.label,
              errorText: state.hasError ? state.errorText : null,
              labelStyle: TextStyle(
                color: Colors.grey[700],
                fontSize: 18
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.grey[350]),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0)
            ),
            child: Container(
              child: Text('$_currentDate', style: TextStyle(fontSize: 18.0)),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0)
            )
          ),
          onTap: () => _datePicker(context)
        );
      }
    );
  }
}