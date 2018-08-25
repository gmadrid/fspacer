import 'package:test/test.dart';

import 'package:fspacer/state_machine.dart';

void main() {
  State<String> init;
  State<String> next;
  State<String> unconnected;

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

  StateMachine<int> _machine;

  var one23 = false;
  var three24 = false;
  var one22 = false;

  _makeStateMachine() {
    _machine = StateMachine<int>();

    var oneToThreeCalled = () { one23 = true; };
    var threeToFourCalled = () { three24 = true; };
    var oneToTwoCalled = () { one22 = true; };

    _machine.addStates([1, 2, 3, 4]);
    _machine.addStateTransition(1, 3, oneToThreeCalled);
    _machine.addStateTransition(3, 4, threeToFourCalled);
    _machine.addStateTransition(1, 2, oneToTwoCalled);
  }

  // Now, test the state machine.
  test("state machine", () {
    _makeStateMachine();
    _machine.advanceTo(3);
    expect(one23, isTrue);

    expect(three24, isFalse);
    _machine.advanceTo(4);
    expect(three24, isTrue);

    expect(() {
      _machine.advanceTo(2);
    }, throwsA(BadSuccessorException));
  });

}
