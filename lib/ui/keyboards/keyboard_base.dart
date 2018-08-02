import 'package:flutter/material.dart';

typedef void KeyCallback(String key);

abstract class KeyboardBase extends StatelessWidget {
  final EdgeInsets padding;
  final TextStyle textStyle;
  final KeyCallback onPressed;

  KeyboardBase({this.padding, @required this.textStyle, this.onPressed});

  Widget buildInputButton(String txt) {
    VoidCallback callback;
    if (txt.isNotEmpty) {
      callback = () => onPressed(txt);
    }
    return Container(
      child: MaterialButton(
        child: Text(
          txt,
          style: textStyle,
        ),
        onPressed: callback,
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
}
