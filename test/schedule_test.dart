import 'package:test/test.dart';

    import 'package:fspacer/schedule.dart';

    void main() {
      test('Base', () {
        var s = Schedule(7);
        expect(s.Current(), equals(1));
      });

      test('FirstPop', () {
        var s = Schedule(4);

        expect(s.Current(), equals(1));
        s.PopCurrent();
        expect(s.Current(), equals(2));
      });

      test('extended', (){
        var s = Schedule(4);

        // 1/2/3/4
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 2 1/3/4
        expect(s.Current(), equals(2));
        s.PopCurrent();

        // 1/3/4 2
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 3 1/4/2
        expect(3, equals(s.Current()));
        expect(s.Current(), equals(3));
        s.PopCurrent();

        // 1/4 2//3
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 4 2 1//3
        expect(s.Current(), equals(4));
        s.PopCurrent();

        // 2 1 //3//4
        expect(s.Current(), equals(2));
        s.PopCurrent();

        // 1//3 2//4
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 1/3 2//4
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 3 2 1 //4
        expect(s.Current(), equals(3));
        s.PopCurrent();

        // 2 1//4/3
        expect(s.Current(), equals(2));
        s.PopCurrent();

        // 1//4 2/3
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 1/4 2/3
        expect(s.Current(), equals(1));
        s.PopCurrent();

        // 4 2 1/3
        expect(s.Current(), equals(4));
      });
    }