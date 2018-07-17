import 'question.dart';

class LeitnerBox {
  LeitnerBox() {
//    _buckets = List();
//    for (var i = 0; i < _total_buckets; ++i) {
//      _buckets.add(List());
//    }
  }

  void AddQuestions(Iterable<Question> questions) {}
  num Size() {return 0;}
  num BucketSize(num index) { return 0; }

  Question Next(num index) { return null; }

  void Shuffle(num index) { return; }
  void MoveToFirst(num index) { return; }
  void MoveUp(num index) { return; }

  static const num first_bucket = 1;
  static const num last_bucket = 7;
  static const num waiting_bucket = 0;

  static const num _total_buckets = last_bucket + 1;

  List<List<Question>> _buckets;
}
