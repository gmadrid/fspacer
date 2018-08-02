import 'package:flutter/material.dart';
import 'package:fspacer/leitner/game.dart';
import 'package:fspacer/leitner/mnemonica.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/ui/keyboards/keyboard_base.dart';

import 'display_widget.dart';
import 'input_widget.dart';
import 'status_widget.dart';

class GameWidget extends StatefulWidget {
  @override
  State createState() => GameState(Game());
}

class GameState extends State<GameWidget> implements GameListener {
  GameState(Game game)
      : this._game = game,
        super() {
    game.listener = this;
    game.start();
  }

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

  List<Question> initializing() {
    var qs = List<Question>();
    var mnemonicaQuestions = mnemonica.split(':');
    for (var i = 0; i < mnemonicaQuestions.length; ++i) {
      qs.add(Question(mnemonicaQuestions[i], (i + 1).toString()));
    }
    return qs;
  }

  void newQuestion(Question q) {}

  void questioning(Question q) {}

  void answeredWrong(Question q, String response, bool timeout) {}

  void answeredRight(Question q) {}

  void addingQuestions() {}

  void addedQuestions() {}

  responseCorrect(Question q, String resp) {
    print("Correct");
    resetStringSoFar();
  }

  responseIncorrect(Question q, String resp) {
    print("Wrong");
    resetStringSoFar();
  }

  stateChange(GameLifecycleState gameState) {}

  resetStringSoFar() => _stringSoFar = "";

  final Game _game;
  String _stringSoFar = "";
}
