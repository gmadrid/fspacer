import 'package:test/test.dart';

import 'package:fspacer/leitner/game.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:fspacer/leitner/shuffler.dart';

class TestListener implements GameListener {
  responseCorrect(Question q, String resp) => result = true;
  responseIncorrect(Question q, String resp) => result = false;

  bool result;
}

void main() {
  Game _game;
  TestListener _listener;

  setUp(() {
    _listener = TestListener();
    _game = Game(15, shuffler: NoOpShuffler(), listener: _listener);
  });

  test("game creation", () {
    expect(_game, isNotNull);
  });

  test("first card", () {
    // Assumes Mnemonica and no shuffling.
    // (With no shuffling, the first card is actually #52.)
    expect(_game.currentCard.a, equals("9D"));
  });

  test("partial input correct", () {
    _game.tryInput("9");
    expect(_listener.result, isNull);
  });

  test("full input correct", () {
    _game.tryInput("9D");
    expect(_listener.result, isTrue);
  });

  test("partial input incorrect", () {
    _game.tryInput("4");
    expect(_listener.result, isFalse);
  });

  test("full input incorrect", () {
    _game.tryInput("9C");
    expect(_listener.result, isFalse);
  });

  test("null listener correct", () {
    _game.listener = null;
    _game.tryInput("9C");
  });

  test("null listener incorrect", () {
    _game.listener = null;
    _game.tryInput("XX");
  });
}
