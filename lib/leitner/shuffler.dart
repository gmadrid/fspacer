abstract class Shuffler {
  void shuffle(List arr);
}

class RandomShuffler implements Shuffler {
  void shuffle(List arr) {
    arr.shuffle();
  }
}

class NoOpShuffler implements Shuffler {
  void shuffle(List arr) {}
}
