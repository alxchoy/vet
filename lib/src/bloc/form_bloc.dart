import 'dart:async';

import 'package:flutter/widgets.dart';

import './bloc_provider.dart';

class FormBloc extends BlocBase {
  final Map<String, StreamController> inputsStream;

  FormBloc({@required this.inputsStream});

  Stream getInputValue({String input}) => inputsStream[input].stream;

  void onChangeInput({String input, value}) {
    print(value);
    inputsStream[input].sink.add(value);
  }

  @override
  void dispose({String input}) {
    inputsStream[input]?.close();
  }
}