import 'package:flutter/material.dart';

import 'keyboard_base.dart';

class NumericKeyboard extends KeyboardBase {
  NumericKeyboard(
      {EdgeInsets padding, TextStyle textStyle, KeyCallback onPressed})
      : super(padding: padding, textStyle: textStyle, onPressed: onPressed);

      Widget _buildNumberButton(String txt, TextStyle style) {
        VoidCallback callback;
        if (txt.isNotEmpty) {
          callback = () => onPressed(txt);
        }
        return Container(
          child: MaterialButton(
            child: Text(
              txt,
              style: style,
            ),
            onPressed: callback,
          ),
          padding: EdgeInsets.all(8.0),
        );
      }

      @override
      Widget build(BuildContext context) {
    TextStyle style = textStyle ?? Theme
        .of(context)
        .textTheme
        .display1;

    return Container(
        padding: padding ?? EdgeInsets.only(top: 8.0),
        child: Table(
          children: <TableRow>[
            TableRow(children: <Widget>[
              _buildNumberButton("7", style),
              _buildNumberButton("8", style),
              _buildNumberButton("9", style),
            ]),
            TableRow(children: <Widget>[
              _buildNumberButton("4", style),
              _buildNumberButton("5", style),
              _buildNumberButton("6", style),
            ]),
            TableRow(children: <Widget>[
              _buildNumberButton("1", style),
              _buildNumberButton("2", style),
              _buildNumberButton("3", style),
            ]),
            TableRow(children: <Widget>[
              _buildNumberButton("", style),
              _buildNumberButton("0", style),
              _buildNumberButton("", style),
            ]),
          ],
        ));
  }
}
