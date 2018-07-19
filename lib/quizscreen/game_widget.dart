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
    VoidCallback kkk = () {
      setState(() {
        _game.tryInput("foo");
      });
    };
    return Column(
      children: <Widget>[
        DisplayWidget(_game.currentCard),
        StatusWidget(_game),
        InputWidget(kkk)
      ],
    );
  }

  Game _game = Game(10);
}
