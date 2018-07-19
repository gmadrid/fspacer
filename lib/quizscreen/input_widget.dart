import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  InputWidget(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              child: Text("Get it right"),
              onPressed: _onPressed
          ),
          FlatButton(
              child: Text("Get it wrong"),
              onPressed: _onPressed
          )
        ],
      ),
    ));
  }

  final VoidCallback _onPressed;
}
