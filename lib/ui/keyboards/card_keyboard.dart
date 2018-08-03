import 'package:flutter/material.dart';

import 'package:fspacer/ui/card_helpers.dart';

import 'keyboard_base.dart';

class CardKeyboard extends KeyboardBase {
  CardKeyboard(
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
            buildInputButton("1"),
            buildInputButton("2"),
            buildInputButton("3"),
            buildInputButton(""),
            buildInputButton(symbolForSuit("S")),
          ]),
          TableRow(children: <Widget>[
            buildInputButton("4"),
            buildInputButton("5"),
            buildInputButton("6"),
            buildInputButton(""),
            buildInputButton(symbolForSuit("H")),
          ]),
          TableRow(children: <Widget>[
            buildInputButton("7"),
            buildInputButton("8"),
            buildInputButton("9"),
            buildInputButton(""),
            buildInputButton(symbolForSuit("D")),
          ]),
          TableRow(children: <Widget>[
            buildInputButton("10"),
            buildInputButton("J"),
            buildInputButton("Q"),
            buildInputButton("K"),
            buildInputButton(symbolForSuit("C")),
          ]),
        ],
      )
    );
  }
}