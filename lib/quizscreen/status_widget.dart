import 'package:flutter/material.dart';

import 'package:fspacer/leitner/game.dart';

class StatusWidget extends StatelessWidget {
  StatusWidget(this._game);

  final Game _game;

  @override
  Widget build(BuildContext context) {
    return Text(_game.status);
  }
}
