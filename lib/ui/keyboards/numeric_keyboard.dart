import 'package:flutter/material.dart';

import 'keyboard_base.dart';

class NumericKeyboard extends KeyboardBase {
  NumericKeyboard(
      {EdgeInsets padding,
      @required TextStyle textStyle,
      KeyCallback onPressed})
      : super(padding: padding, textStyle: textStyle, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.only(top: 8.0),
        child: Table(
          children: <TableRow>[
            TableRow(children: <Widget>[
              buildInputButton("7"),
              buildInputButton("8"),
              buildInputButton("9"),
            ]),
            TableRow(children: <Widget>[
              buildInputButton("4"),
              buildInputButton("5"),
              buildInputButton("6"),
            ]),
            TableRow(children: <Widget>[
              buildInputButton("1"),
              buildInputButton("2"),
              buildInputButton("3"),
            ]),
            TableRow(children: <Widget>[
              buildInputButton(""),
              buildInputButton("0"),
              buildInputButton(""),
            ]),
          ],
        ));
  }
}
