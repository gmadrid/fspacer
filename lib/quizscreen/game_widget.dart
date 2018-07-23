import 'package:flutter/material.dart';

import 'package:fspacer/leitner/game.dart';

import 'display_widget.dart';
import 'status_widget.dart';
import 'input_widget.dart';

class GameWidget extends StatefulWidget {
  @override
  State createState() => GameState();
}

class GameState extends State<GameWidget> {
  @override
  Widget build(BuildContext context) {
    KeyCallback keyCallback = (inp) {
      setState(() {
        _game.tryInput("foo");
      });
    };
    return Column(
      children: <Widget>[
        StatusWidget(_game),
        DisplayWidget(_game.currentCard),
        Divider(color: Colors.black54),
        InputWidget(keyCallback)
      ],
    );
  }

  Game _game = Game(10);
}
