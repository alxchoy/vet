import 'package:flutter/material.dart';

import '../../bloc/bloc_provider.dart';
import '../../bloc/form_bloc.dart';

class VetInput extends StatefulWidget {
  final String label;
  final String initValue;
  final String inputType;
  final Icon icon;
  final String validationType;
  final dynamic onSave;
  final bool required;

  final String inputProperty;

  VetInput({this.label, this.initValue, this.validationType, this.onSave, this.inputType, this.icon, this.required = true, this.inputProperty});

  @override
  _VetInputState createState() => _VetInputState();
}

class _VetInputState extends State<VetInput> {
  FormBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<FormBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('INPUT::: ${_bloc.inputsStream}');
    return StreamBuilder(
      stream: _bloc.getInputValue(input: widget.inputProperty),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            icon: widget.icon,
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
          onChanged: (val) => _bloc.onChangeInput(input: widget.inputProperty, value: val)
        );
      }
    );



    // return TextFormField(
    //   decoration: InputDecoration(
    //     icon: widget.icon ?? null,
    //     labelText: widget.label,
    //     labelStyle: TextStyle(
    //       color: Colors.grey[700],
    //       fontSize: 18
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(30.0),
    //       borderSide: BorderSide(color: Colors.grey[350]),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(30.0),
    //       borderSide: BorderSide(color: Colors.red),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(27.0),
    //       borderSide: BorderSide(color: Colors.grey[350]),
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(27.0),
    //       borderSide: BorderSide(color: Colors.red),
    //     ),
    //     contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0)
    //   ),
    //   style: TextStyle(fontSize: 18.0),
    //   initialValue: widget.initValue,
    //   obscureText: widget.inputType == 'password',
    //   onSaved: widget.onSave,
    //   validator: (val) {
    //     if (val.isEmpty && widget.required) {
    //       return 'Campo requerido';
    //     }
    //   }
    // );
  }
}