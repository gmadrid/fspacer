import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  InputWidget(this._onPressed);

  final VoidCallback _onPressed;

  Widget buildNumberButton(String txt, TextStyle style) {
    VoidCallback onPressed = null;
    if (txt.isNotEmpty) {
      onPressed = _onPressed;
    }
    return Container(
      child: MaterialButton(
        child: Text(
          txt,
          style: style,
        ),
        onPressed: onPressed,
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  Table buildNumpad(TextStyle textStyle) {
    return Table(
      children: <TableRow>[
        TableRow(children: <Widget>[
          buildNumberButton("7", textStyle),
          buildNumberButton("8", textStyle),
          buildNumberButton("9", textStyle),
        ]),
        TableRow(children: <Widget>[
          buildNumberButton("4", textStyle),
          buildNumberButton("5", textStyle),
          buildNumberButton("6", textStyle),
        ]),
        TableRow(children: <Widget>[
          buildNumberButton("1", textStyle),
          buildNumberButton("2", textStyle),
          buildNumberButton("3", textStyle),
        ]),
        TableRow(children: <Widget>[
          buildNumberButton("", textStyle),
          buildNumberButton("0", textStyle),
          buildNumberButton("", textStyle),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    return buildNumpad(textStyle);
  }
}
