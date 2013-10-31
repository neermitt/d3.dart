import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('max', () {
    var max = load('arrays/max').expression('d3.max');
    test('returns the greatest numeric value for numbers', () {
      expect(max([1]), equals(1));
      expect(max([5, 1, 2, 3, 4]), equals(5));
      expect(max([20, 3]), equals(20));
      expect(max([3, 20]), equals(20));
    });
    test('returns the greatest lexicographic value for strings', () {
      expect(max(['c', 'a', 'b']), equals('c'));
      expect(max(['20', '3']), equals('3'));
      expect(max(['3', '20']), equals('3'));
    });
    test('ignores null, undefined and double.NAN', () {
      var o = {valueOf: () { return double.NAN; }};
      expect(max([double.NAN, 1, 2, 3, 4, 5]), equals(5));
      expect(max([o, 1, 2, 3, 4, 5]), equals(5));
      expect(max([1, 2, 3, 4, 5, double.NAN]), equals(5));
      expect(max([1, 2, 3, 4, 5, o]), equals(5));
      expect(max([10, null, 3, null/*undefined*/, 5, double.NAN]), equals(10));
      expect(max([-1, null, -3, null/*undefined*/, -5, double.NAN]), equals(-1));
    });
    test('compares heterogenous types as numbers', () {
      expect(max([20, '3']), same(20));
      expect(max(['20', 3]), same('20'));
      expect(max([3, '20']), same('20'));
      expect(max(['3', 20]), same(20));
    });
    test('returns undefined for empty array', () {
      expect(max([]), isUndefined);
      expect(max([null]), isUndefined);
      expect(max([null/*undefined*/]), isUndefined);
      expect(max([double.NAN]), isUndefined);
      expect(max([double.NAN, double.NAN]), isUndefined);
    });
    test('applies the optional accessor function', () {
      expect(max([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]], (d) {
        return _.min(d);
      }), equals(2));
      expect(max([1, 2, 3, 4, 5], (d, i) { return i; }), equals(4));
    });
  });
}