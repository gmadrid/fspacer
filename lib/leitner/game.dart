import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/mnemonica.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/schedule.dart';

const num _DEFAULT_NUM_QUESTIONS = 5;

class Game {
  Game(num timeoutSecs)
      : _schedule = Schedule(7) {
    _lb = LeitnerBox();

    var qs = List<Question>();
    var mnemonicaQuestions = mnemonica.split(':');
    for (var i = 0; i < mnemonicaQuestions.length; ++i) {
      qs.add(Question((i + 1).toString(), mnemonicaQuestions[i]));
    }

    _lb.AddQuestions(qs);
    _lb.Shuffle(LeitnerBox.waiting_bucket);
  }

  String get status {
    return "Level: ${_schedule.Current()}";
  }

  String get currentCard {
    var bucketIndex = _schedule.Current();
    while (_lb.BucketSize(bucketIndex) == 0) {
      // TODO: this will infinite loop if the box is empty.
        _schedule.PopCurrent();
        bucketIndex = _schedule.Current();

        if (bucketIndex == LeitnerBox.first_bucket &&
            _lb.BucketSize(LeitnerBox.first_bucket) == 0) {
          _addQuestionsToFirstBucket();
        }
    }

    var card = _lb.Next(bucketIndex);
    return card.a;
  }

  void _addQuestionsToFirstBucket() {
    // TODO: deal with case when the "waiting" box is empty.
    for (var i = 0; i < _DEFAULT_NUM_QUESTIONS; ++i) {
      _lb.MoveToFirst(LeitnerBox.waiting_bucket);
    }
  }

  bool tryInput(String input) {
    _lb.MoveUp(_schedule.Current());
    return false;
  }

  LeitnerBox _lb;
  Schedule _schedule;
//  num _timeoutSecs;
}
