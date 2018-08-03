import 'package:async/async.dart';
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
    _timer = RestartableTimer(Duration(milliseconds: 250), () => this._tick())
      ..cancel();
    _stopwatch = Stopwatch();

    game.listener = this;
    game.start();
  }

  final Game _game;
  String _stringSoFar = "";
  RestartableTimer _timer;
  Stopwatch _stopwatch;
  Question _currentQuestion = Question("AS", "7");
  double _elapsedPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    KeyCallback keyCallback = (inp) {
      setState(() {
        _stringSoFar += inp;
        _game.tryInput(_stringSoFar);
      });
    };
    return Column(
      children: <Widget>[
        StatusWidget(_game),
        DisplayWidget(_currentQuestion.q, _elapsedPercentage),
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

  void _tick() {
    setState(() {
      print("ticking: ${_stopwatch.elapsed}");
      var timeout = Duration(seconds: 10).inMilliseconds;
      _elapsedPercentage = 100 * _stopwatch.elapsedMilliseconds / timeout;
      print("PCT: $_elapsedPercentage");
      _timer.reset();
    });
  }

  void newQuestion(Question q) {
    print("In newQuestion");
    _stopwatch.start();
    _timer.reset();
    _currentQuestion = q;
  }

  void questioning(Question q) {}

  void answeredWrong(Question q, String response) {}

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
}
