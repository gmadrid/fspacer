import 'package:fspacer/leitner/question.dart';

class LeitnerBox {
  LeitnerBox() {
    _buckets = List();
    for (var i = 0; i < _total_buckets; ++i) {
      _buckets.add(List());
    }
  }

  void addQuestions(Iterable<Question> questions, {bool shuffle = true}) {
    _buckets[waiting_bucket].addAll(questions);
    _numQuestions += questions.length;
    if (shuffle) {
      this.shuffle(waiting_bucket);
    }
  }
  num size() {return _numQuestions;}
  num bucketSize(num index) { return _buckets[index].length; }

  Question next(num index) {
    if (_buckets[index].length == 0) return null;
    return _buckets[index].last;
  }

  void shuffle(num index) {
    _buckets[index].shuffle();
  }

  void moveToFirst(num index) {
    if (bucketSize(index) < 1) return;

    var fromBucket = _buckets[index];
    var q = fromBucket.last;
    fromBucket.removeLast();
    _buckets[first_bucket].insert(0, q);
  }

  void moveUp(num index) {
    if (bucketSize(index) < 1) return;

    // TODO: have a way to deal with this case.
    if (index == last_bucket) return;

    var fromBucket = _buckets[index];
    var q = fromBucket.last;
    fromBucket.removeLast();
    _buckets[index + 1].insert(0, q);
  }

  static const num first_bucket = 1;
  static const num last_bucket = 7;
  static const num waiting_bucket = 0;

  static const num _total_buckets = last_bucket + 1;

  List<List<Question>> _buckets;
  num _numQuestions = 0;
}
