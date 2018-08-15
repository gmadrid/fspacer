typedef void TransitionCallback();

class DuplicateTransitionException implements Exception {
  DuplicateTransitionException();
}

class BadSuccessorException implements Exception {
  BadSuccessorException();
}

class UnknownStateException implements Exception {
  UnknownStateException();
}

class State {
  final String name;
  final Map<State, TransitionCallback> nextStates = Map();

  State(this.name);

  void addSuccessor(State succ, TransitionCallback callback) {
    if (nextStates.containsKey(succ)) throw DuplicateTransitionException;

    nextStates[succ] = callback;
  }

  bool hasSuccessor(State succ) {
    return nextStates.containsKey(succ);
  }

  void advance(State succ) {
    var f = nextStates[succ];
    if (f == null) {
      throw BadSuccessorException;
    }
    f();
  }
}

class StateMachine {
  StateMachine() : _states = Map();

  final Map<String, State> _states;
  State _currentState = null;

  String get currentState => _currentState.name;

  // The first state will be the start state.
  void addStates(List<String> states) {
    states.forEach((stateName) {
      State state = State(stateName);
      _currentState ??= state;
      _states[stateName] = state;
    });
  }

  void addStateTransition(String from, String to, TransitionCallback callback) {
    State fromState = _states[from];
    if (fromState == null) throw UnknownStateException;

    State toState = _states[to];
    if (toState == null) throw UnknownStateException;

    fromState.addSuccessor(toState, callback);
  }

  void advanceTo(String to) {
    State toState = _states[to];
    if (toState == null) throw UnknownStateException;
    _currentState.advance(toState);
    _currentState = toState;
  }
}
