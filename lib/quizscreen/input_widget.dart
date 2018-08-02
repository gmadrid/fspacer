import 'package:flutter/material.dart';

import 'package:fspacer/ui/keyboards/keyboard_base.dart';
import 'package:fspacer/ui/keyboards/numeric_keyboard.dart';

class InputWidget extends StatelessWidget {
  InputWidget(this._onPressed);

  final KeyCallback _onPressed;

  @override
  Widget build(BuildContext context) => NumericKeyboard(onPressed: _onPressed);
}
