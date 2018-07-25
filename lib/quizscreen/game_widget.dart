import 'package:flutter/material.dart';

import 'package:fspacer/leitner/game.dart';
import 'package:fspacer/leitner/question.dart';

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
    KeyCallback keyCallback = (inp) {
      print("SSFB: $_stringSoFar");
      _stringSoFar += inp;
      print("SSF: $_stringSoFar");
      setState(() {
        _game.tryInput(_stringSoFar);
      });
    };
    return Column(
      children: <Widget>[
        StatusWidget(_game),
        DisplayWidget(_game.currentCard.q),
        Divider(color: Colors.black54),
        InputWidget(keyCallback)
      ],
    );
  }

  responseCorrect(Question q, String resp) {
    resetStringSoFar();
  }

  responseIncorrect(Question q, String resp) {
    resetStringSoFar();
  }

  resetStringSoFar() => _stringSoFar = "";

  Game _game = Game(10);
  String _stringSoFar = "";
}
