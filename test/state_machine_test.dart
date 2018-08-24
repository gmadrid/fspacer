import 'package:test/test.dart';

import 'package:fspacer/state_machine.dart';

void main() {
  State init;
  State next;
  State unconnected;

  setUp(() {
    init = State("init");
    next = State("next");
    unconnected = State("unconnected");
  });

  test("state creation", () {
    expect(init, isNotNull);
  });

  test("state with next state", () {
    init.addSuccessor(next, () {});

    expect(init.hasSuccessor(next), isTrue);
    expect(next.hasSuccessor(init), isFalse);
  });

  test("state witn duplicate state", () {
    init.addSuccessor(next, () {});
    expect(() {
      init.addSuccessor(next, () {});
    }, throwsA(DuplicateTransitionException));
  });

  test("bad advance", () {
    init.addSuccessor(next, () {});
    expect(() {
      init.advance(unconnected);
    }, throwsA(BadSuccessorException));
  });

  test("advance", () {
    var called = false;
    init.addSuccessor(next, () { called = true; });
    init.advance(next);
    expect(called, isTrue);
  });
}

//void main() {
//  Game _game;
//  TestListener _listener;
//
//  setUp(() {
//    _listener = TestListener();
//    _game = Game(15, shuffler: NoOpShuffler(), listener: _listener);
//  });
//
//  test("game creation", () {
//    expect(_game, isNotNull);
//  });
//
//  test("first card", () {
//    // Assumes Mnemonica and no shuffling.
//    // (With no shuffling, the first card is actually #52.)
//    expect(_game.currentCard.a, equals("9D"));
