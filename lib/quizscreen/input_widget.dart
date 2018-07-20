import 'package:flutter/material.dart';

import 'package:fspacer/colors.dart';

class InputWidget extends StatelessWidget {
  InputWidget(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlineButton(
          child: Text("WRONG"),
          onPressed: () {},
        ),
        RaisedButton(
          child: Text("RIGHT", style: Theme.of(context).textTheme.button.copyWith(
            color: onPrimaryColor,
          ),),
          onPressed: () {},
        ),
      ],
    ));
  }

  final VoidCallback _onPressed;
}
