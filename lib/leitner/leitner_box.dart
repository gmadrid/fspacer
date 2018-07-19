import 'package:fspacer/leitner/question.dart';

class LeitnerBox {
  LeitnerBox() {
    _buckets = List();
    for (var i = 0; i < _total_buckets; ++i) {
      _buckets.add(List());
    }
  }

  void AddQuestions(Iterable<Question> questions) {
    _buckets[waiting_bucket].addAll(questions);
    _num_questions += questions.length;
    Shuffle(waiting_bucket);
  }
  num Size() {return _num_questions;}
  num BucketSize(num index) { return _buckets[index].length; }

  Question Next(num index) {
    if (_buckets[index].length == 0) return null;
    return _buckets[index].last;
  }

  void Shuffle(num index) {
    _buckets[index].shuffle();
  }

  void MoveToFirst(num index) {
    if (BucketSize(index) < 1) return;

    var from_bucket = _buckets[index];
    var q = from_bucket.last;
    from_bucket.removeLast();
    _buckets[first_bucket].insert(0, q);
  }

  void MoveUp(num index) {
    if (BucketSize(index) < 1) return;

    // TODO: have a way to deal with this case.
    if (index == last_bucket) return;

    var from_bucket = _buckets[index];
    var q = from_bucket.last;
    from_bucket.removeLast();
    _buckets[index + 1].insert(0, q);
  }

  static const num first_bucket = 1;
  static const num last_bucket = 7;
  static const num waiting_bucket = 0;

  static const num _total_buckets = last_bucket + 1;

  List<List<Question>> _buckets;
  num _num_questions = 0;
}
