import 'package:flutter/material.dart';

typedef void KeyCallback(String key);

abstract class KeyboardBase extends StatelessWidget {
  final EdgeInsets padding;
  final TextStyle textStyle;
  final KeyCallback onPressed;

  KeyboardBase({this.padding, this.textStyle, this.onPressed});
}
