import 'package:flutter/material.dart';

class VetLoading extends StatelessWidget {
  const VetLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          child: ModalBarrier(color: Colors.grey),
          opacity: 0.3
        ),
        Center(child: CircularProgressIndicator())
      ],
    );
  }
}