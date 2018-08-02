import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/schedule.dart';
import 'package:fspacer/leitner/shuffler.dart';

const num _DEFAULT_NUM_QUESTIONS = 5;

abstract class GameListener {
  List<Question> initializing();
  void newQuestion(Question q);
  void questioning(Question q);
  void answeredWrong(Question q, String response, bool timeout);
  void answeredRight(Question q);
  void addingQuestions();
  void addedQuestions();

  responseCorrect(Question q, String resp);
  responseIncorrect(Question q, String resp);
  stateChange(GameLifecycleState gameState);
}

/*
                                    +--> AnsweredRight --+
                                   /                      \
    NewQuestion --> Questioning --<                        +------+
        ^                          \                      /       |
        |                           \--> AnsweredWrong --+        |
        |                                                         |
        +--[AddedQuestions] <--------- [AddingQuestions] <--------+

 */
enum GameLifecycleState {
  // Initializing. An opportunity to change the question set.
  Initializing,

  // The question has just been changed to a new Question.
  NewQuestion,

  // We are waiting for a response to the current question.
  Questioning,

  // The current question was answered incorrectly.
  AnsweredWrong,

  // The current question was answered correctly.
  AnsweredRight,

  // The game is about to add new questions to the box.
  AddingQuestions,

  // The game just added new questions to the box.
  AddedQuestions
}

class Game {
  Game({this.listener, Shuffler shuffler, Duration timeout})
      : _schedule = Schedule(7),
        _lb = LeitnerBox(shuffler: shuffler) {
  }

  LeitnerBox _lb;
  Schedule _schedule;
  GameListener listener;

  void start() {
    var questions = listener.initializing();

    _lb.addQuestions(questions);
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
}
