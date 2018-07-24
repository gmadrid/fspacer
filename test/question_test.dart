import 'package:fspacer/leitner/question.dart';
import 'package:test/test.dart';

main() {
  test("Default question", () {
    var q = Question("foo", "barb");
    expect(q.q, equals("foo"));
    expect(q.a, equals("barb"));
  });

  test("Equality and hash", () {
    var q1 = Question("Quux", "Foo");
    var q2 = Question("Quux", "Foo");
    expect(q1, equals(q2));

    expect(q1.hashCode, equals(q2.hashCode));

    var q3 = Question("Bam", "Foo");
    var q4 = Question("Quux", "Shoop");

    expect(q3, isNot(equals(q1)));
    expect(q3.hashCode, isNot(equals(q1.hashCode)));
    expect(q4, isNot(equals(q1)));
    expect(q4.hashCode, isNot(equals(q1.hashCode)));
  });

  test("case-insensitive match", () {
    var q = Question("QQ", "AnSwEr");
    expect(q.match("answer"), isTrue);
    expect(q.match("ANSWER"), isTrue);
    expect(q.match("aNsWeR"), isTrue);
  });
}
