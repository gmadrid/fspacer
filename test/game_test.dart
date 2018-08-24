import 'package:test/test.dart';

import 'package:fspacer/leitner/game.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/shuffler.dart';

const int NUM_TEST_QUESTIONS = 25;

class TestListener implements GameListener {
//  responseCorrect(Question q, String resp) => result = true;
//  responseIncorrect(Question q, String resp) => result = false;

  List<Question> initializing() {
    initializingCalled++;

    var questions = List<Question>();
    for (var i = 0; i < NUM_TEST_QUESTIONS; ++i) {
      questions.add(Question("Q$i", "A$i"));
    }

    // Reverse the questions, since the LeitnerBox starts choosing
    // questions from the back of the list.
    return List.from(questions.reversed);
  }

  void newQuestion(Question q) {
    lastNewQuestion = q;
    newQuestionCalled++;
  }
  void answeredWrong(Question q, String response) {}
  void answeredRight(Question q) {}
  void addingQuestions() { addingQuestionsCalled++; }
  void addedQuestions() { addedQuestionsCalled++; }

  int addedQuestionsCalled = 0;
  int addingQuestionsCalled = 0;
  int initializingCalled = 0;
  int newQuestionCalled = 0;

  Question lastNewQuestion;
}

_makeGame() => Game(listener: TestListener(), shuffler: NoOpShuffler(), timeout: Duration(seconds: 10));

void main() {
  Game _game;
  TestListener _listener;

  setUp(() {
    _game = _makeGame();
    _listener = _game.listener;
    _game.start();
  });

  test("game prestart", () {
    Game game = _makeGame();

    expect(game.state, equals(GameLifecycleState.Unknown));
  });

  test("game creation", () {
    expect(_game, isNotNull);
    expect(_listener.initializingCalled, equals(1));
    expect(_listener.addingQuestionsCalled, equals(1));
    expect(_listener.addedQuestionsCalled, equals(1));
    expect(_listener.newQuestionCalled, equals(1));
    expect(_game.totalQuestions, equals(NUM_TEST_QUESTIONS));

    expect(_game.state, equals(GameLifecycleState.NewQuestion));
    expect(_listener.lastNewQuestion, equals(Question("Q0", "A0")));
  });

//  test("game creation", () {
//    expect(_game, isNotNull);
//  });
//
//  test("first card", () {
//    // Assumes Mnemonica and no shuffling.
//    // (With no shuffling, the first card is actually #52.)
//    expect(_game.currentCard.a, equals("9D"));
//  });
//
//  test("partial input correct", () {
//    _game.tryInput("9");
//    expect(_listener.result, isNull);
//  });
//
//  test("full input correct", () {
//    _game.tryInput("9D");
//    expect(_listener.result, isTrue);
//  });
//
//  test("partial input incorrect", () {
//    _game.tryInput("4");
//    expect(_listener.result, isFalse);
//  });
//
//  test("full input incorrect", () {
//    _game.tryInput("9C");
//    expect(_listener.result, isFalse);
//  });
//
//  test("null listener correct", () {
//    _game.listener = null;
//    _game.tryInput("9C");
//  });
//
//  test("null listener incorrect", () {
//    _game.listener = null;
//    _game.tryInput("XX");
//  });
}
