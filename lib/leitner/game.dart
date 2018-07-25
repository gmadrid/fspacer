import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/mnemonica.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/schedule.dart';
import 'package:fspacer/leitner/shuffler.dart';

const num _DEFAULT_NUM_QUESTIONS = 5;

abstract class GameListener {
  responseCorrect(Question q, String resp);

  responseIncorrect(Question q, String resp);
}

class Game {
  Game(num timeoutSecs, {this.listener, Shuffler shuffler})
      : _schedule = Schedule(7) {
    _lb = LeitnerBox(shuffler: shuffler);

    var qs = List<Question>();
    var mnemonicaQuestions = mnemonica.split(':');
    for (var i = 0; i < mnemonicaQuestions.length; ++i) {
      qs.add(Question(mnemonicaQuestions[i], (i + 1).toString()));
    }

    _lb.addQuestions(qs);
    _lb.shuffle(LeitnerBox.waiting_bucket);
    _addQuestionsToFirstBucket();
  }

  // TODO: get rid of this.
  String get status {
    return "Level: ${_schedule.current()}";
  }

  Question get currentCard {
    var bucketIndex = _schedule.current();
    while (_lb.bucketSize(bucketIndex) == 0) {
      // TODO: this will infinite loop if the box is empty.
      _schedule.popCurrent();
      bucketIndex = _schedule.current();

      if (bucketIndex == LeitnerBox.first_bucket &&
          _lb.bucketSize(LeitnerBox.first_bucket) == 0) {
        _addQuestionsToFirstBucket();
      }
    }

    var card = _lb.next(bucketIndex);
    return card;
  }

  void _addQuestionsToFirstBucket() {
    // TODO: deal with case when the "waiting" box is empty.
    for (var i = 0; i < _DEFAULT_NUM_QUESTIONS; ++i) {
      _lb.moveToFirst(LeitnerBox.waiting_bucket);
    }
  }

  void tryInput(String input) {
    var card = currentCard;
    if (input == card.a) {
      _lb.moveUp(_schedule.current());
      listener?.responseCorrect(card, input);
    }

    if (!card.a.startsWith(input)) {
      _lb.moveToFirst(_schedule.current());
      listener?.responseIncorrect(card, input);
    }
  }

  LeitnerBox _lb;
  Schedule _schedule;
  GameListener listener;
}
