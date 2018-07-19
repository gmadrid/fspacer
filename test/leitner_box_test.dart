import 'package:fspacer/leitner/leitner_box.dart';
import 'package:fspacer/leitner/question.dart';
import 'package:test/test.dart';

String Q(num index) {
  return "Question $index";
}

String A(num index) {
  return "Answer $index";
}

LeitnerBox simpleTestSet(num size) {
  var questions = List<Question>();

  for (var i = 0; i < size; ++i) {
    questions.add(Question(Q(i), A(i)));
  }

  var lb = LeitnerBox();
  lb.addQuestions(questions);
  return lb;
}

void main() {
  test("empty", () {
    var lb = LeitnerBox();

    expect(lb.size(), equals(0));

    for (var i = LeitnerBox.waiting_bucket; i <= LeitnerBox.last_bucket; ++i) {
      lb.shuffle(i);
      expect(lb.bucketSize(i), equals(0));
    }

    lb.moveToFirst(0);
    lb.moveUp(0);
  });

  test("starts in bucket 0", () {
    var size = 34;
    var lb = simpleTestSet(size);
    expect(lb.size(), equals(size));
    expect(lb.bucketSize(0), equals(size));
  });

  test("simple next", () {
    var size = 3;
    var lb = simpleTestSet(size);

    var q = lb.next(0);
    expect(q.q, equals(Q(size - 1)));
  });

  test("simple moves", () {
    var size = 5;
    var lb = simpleTestSet(size);
    expect(lb.bucketSize(0), equals(size));

    var q0 = lb.next(0);
    lb.moveToFirst(0);
    expect(lb.bucketSize(0), equals(size - 1));
    expect(lb.bucketSize(1), equals(1));

    var q1 = lb.next(0);
    expect(q1, isNot(equals(q0)));

    var q2 = lb.next(1);
    expect(q2, equals(q0));
  });

  test("deeper moves", () {
    var size = 11;
    var lb = simpleTestSet(size);
    expect(lb.bucketSize(0), equals(size));

    lb.moveToFirst(0);
    lb.moveToFirst(0);
    lb.moveToFirst(0);
    lb.moveToFirst(0);
    lb.moveToFirst(0);
    lb.moveToFirst(0);

    lb.moveUp(1);
    lb.moveUp(1);
    lb.moveUp(1);

    lb.moveUp(2);

    expect(lb.bucketSize(0), equals(5));
    expect(lb.bucketSize(1), equals(3));
    expect(lb.bucketSize(2), equals(2));
    expect(lb.bucketSize(3), equals(1));
  });
}