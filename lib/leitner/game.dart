import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/mnemonica.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/schedule.dart';

num _DEFAULT_NUM_QUESTIONS = 5;

class Game {
  Game(num timeout_secs)
      : _schedule = Schedule(7),
        _timeout_secs = timeout_secs {
    _lb = LeitnerBox();

    var qs = List<Question>();
    var mnemonicaQuestions = mnemonica.split(':');
    for (var i = 0; i < mnemonicaQuestions.length; ++i) {
      qs.add(Question((i + 1).toString(), mnemonicaQuestions[i]));
    }

    _lb.AddQuestions(qs);
    _lb.Shuffle(LeitnerBox.waiting_bucket);
  }

  LeitnerBox _lb;
  Schedule _schedule;
  num _timeout_secs;
}
