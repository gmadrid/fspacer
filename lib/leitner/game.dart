import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/schedule.dart';
import 'package:fspacer/leitner/shuffler.dart';
import 'package:fspacer/state_machine.dart';

const num _DEFAULT_NUM_QUESTIONS = 5;

/*
                                    +--> AnsweredRight --+
                                   /                      \
    NewQuestion ------------------<                        +------+
        ^                          \                      /       |
        |                           \--> AnsweredWrong --+        |
        |                                                         |
        +--[AddedQuestions] <--------- [AddingQuestions] <--------+
                                            ^
                                            |
                             START --> Initializing

 */
enum GameLifecycleState {
  Unknown,

  // Initializing. An opportunity to change the question set.
  Initializing,

  // The question has just been changed to a new Question.
  NewQuestion,

  // The current question was answered incorrectly.
  AnsweredWrong,

  // The current question was answered correctly.
  AnsweredRight,

  // The game is about to add new questions to the box.
  AddingQuestions,

  // The game just added new questions to the box.
  AddedQuestions
}

abstract class GameListener {
  List<Question> initializing();
  void newQuestion(Question q);
  void answeredWrong(Question q, String response);
  void answeredRight(Question q);
  void addingQuestions();
  void addedQuestions();
}

// The "Game" is basically a big state machine.
// The states are enumerated above.
class Game {
  Game({this.listener, Shuffler shuffler, Duration timeout})
      : _schedule = Schedule(7),
        _lb = LeitnerBox(shuffler: shuffler);
  _machine = _makeStateMachine();

  LeitnerBox _lb;
  Schedule _schedule;
  GameListener listener;
  Question _currentCard;

  static void _makeStateMachine() {
    StateMachine<GameLifecycleState> machine = StateMachine();
    machine.addStates([
      GameLifecycleState.Unknown,
      GameLifecycleState.Initializing,
      GameLifecycleState.NewQuestion,
      GameLifecycleState.AnsweredWrong,
      GameLifecycleState.AnsweredRight,
      GameLifecycleState.AddingQuestions,
      GameLifecycleState.NewQuestion
    ]);

    machine.addStateTransition(GameLifecycleState.Unknown, GameLifecycleState.Initializing, () { this.Initializing(); };);
    machine.addStateTransition(GameLifecycleState.Initializing, GameLifecycleState.AddingQuestions, () { this.AddingQuestions(); });
    machine.addStateTransition(GameLifecycleState.AddingQuestions, GameLifecycleState.AddedQuestions, () {this.AddedQuestions(); });
    machine.addStateTransition(GameLifecycleState.NewQuestion, GameLifecycleState.AnsweredRight, () { this.AnsweredRight(); });
    machine.addStateTransition(GameLifecycleState.NewQuestion, GameLifecycleState.AnsweredWrong, () { this.AnsweredWrong(); });

  }

  int get totalQuestions => _lb.size();

  GameLifecycleState _state = GameLifecycleState.Unknown;
  GameLifecycleState get state => _state;
  set state(GameLifecycleState st) {
    _state = st;
    switch(st) {
      case GameLifecycleState.Initializing:
        _moveToInitializing();
        break;
    }
  }

  void _moveToInitializing() {
    List<Question> qs = listener.initializing();
    _addQuestions(qs);
    _lb.shuffle(LeitnerBox.waiting_bucket);
  }

  void start() {
    state = GameLifecycleState.Initializing;
    _addQuestionsToFirstBucket();
    _prepareNextQuestion();
  }

  void tryInput(String input) {
    var card = _currentCard;
    if (input == card.a) {
      _lb.moveUp(_schedule.current());
      listener?.answeredRight(card);
    }

    if (!card.a.startsWith(input)) {
      _lb.moveToFirst(_schedule.current());
      listener?.answeredWrong(card, input);
    }
  }

  void _addQuestions(List<Question> qs) {
    state = GameLifecycleState.AddingQuestions;
    listener.addingQuestions();

    _lb.addQuestions(qs);
    _lb.shuffle(LeitnerBox.waiting_bucket);

    state = GameLifecycleState.AddedQuestions;
    listener.addedQuestions();
  }

  void _addQuestionsToFirstBucket() {
    // TODO: deal with case when the "waiting" box is empty.
    for (var i = 0; i < _DEFAULT_NUM_QUESTIONS; ++i) {
      _lb.moveToFirst(LeitnerBox.waiting_bucket);
    }
  }

  void _prepareNextQuestion() {
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
    state = GameLifecycleState.NewQuestion;
    _currentCard = card;
    listener.newQuestion(card);
  }



  /// ================================================

  // TODO: get rid of this.
//  String get status {
//    return "Level: ${_schedule.current()}";
//  }
//
}
