import 'package:flutter/material.dart';

import 'package:fspacer/leitner/game.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/ui/keyboards/keyboard_base.dart';

import 'display_widget.dart';
import 'status_widget.dart';
import 'input_widget.dart';

class GameWidget extends StatefulWidget {
  @override
  State createState() => GameState();
}

class GameState extends State<GameWidget> implements GameListener {
  @override
  Widget build(BuildContext context) {
    _game.listener = this;

    KeyCallback keyCallback = (inp) {
      setState(() {
        _stringSoFar += inp;
        _game.tryInput(_stringSoFar);
      });
    };
    return Column(
      children: <Widget>[
        StatusWidget(_game),
        DisplayWidget(_game.currentCard.q),
        InputWidget(keyCallback)
      ],
    );
  }

  responseCorrect(Question q, String resp) {
    print("Correct");
    resetStringSoFar();
  }

  responseIncorrect(Question q, String resp) {
    print("Wrong");
    resetStringSoFar();
  }

  stateChange(GameLifecycleState gameState) {

  }

  resetStringSoFar() => _stringSoFar = "";

  Game _game = Game(10);
  String _stringSoFar = "";
}
