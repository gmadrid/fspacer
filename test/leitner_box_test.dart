import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:test/test.dart';

String Q(num index) {
  return "Question $index";
}

String A(num index) {
  return "Answer $index";
}

LeitnerBox SimpleTestSet(num size) {
  var questions = List<Question>();

  for (var i = 0; i < size; ++i) {
    questions.add(Question(Q(i), A(i)));
  }

  var lb = LeitnerBox();
  lb.AddQuestions(questions);
  return lb;
}

void main() {
  test("empty", () {
    var lb = LeitnerBox();

    expect(lb.Size(), equals(0));

    for (var i = LeitnerBox.waiting_bucket; i <= LeitnerBox.last_bucket; ++i) {
      lb.Shuffle(i);
      expect(lb.BucketSize(i), equals(0));
    }

    lb.MoveToFirst(0);
    lb.MoveUp(0);
  });

  test("starts in bucket 0", () {
    var size = 34;
    var lb = SimpleTestSet(size);
    expect(lb.Size(), equals(size));
    expect(lb.BucketSize(0), equals(size));
  });

  test("simple next", () {
    var size = 3;
    var lb = SimpleTestSet(size);

    var q = lb.Next(0);
    expect(q.q, equals(Q(size - 1)));
  });

  test("simple moves", () {
    var size = 5;
    var lb = SimpleTestSet(size);
    expect(lb.BucketSize(0), equals(size));

    var q0 = lb.Next(0);
    lb.MoveToFirst(0);
    expect(lb.BucketSize(0), equals(size - 1));
    expect(lb.BucketSize(1), equals(1));

    var q1 = lb.Next(0);
    expect(q1, isNot(equals(q0)));

    var q2 = lb.Next(1);
    expect(q2, equals(q0));
  });

  test("deeper moves", () {
    var size = 11;
    var lb = SimpleTestSet(size);
    expect(lb.BucketSize(0), equals(size));

    lb.MoveToFirst(0);
    lb.MoveToFirst(0);
    lb.MoveToFirst(0);
    lb.MoveToFirst(0);
    lb.MoveToFirst(0);
    lb.MoveToFirst(0);

    lb.MoveUp(1);
    lb.MoveUp(1);
    lb.MoveUp(1);

    lb.MoveUp(2);

    expect(lb.BucketSize(0), equals(5));
    expect(lb.BucketSize(1), equals(3));
    expect(lb.BucketSize(2), equals(2));
    expect(lb.BucketSize(3), equals(1));
  });
}