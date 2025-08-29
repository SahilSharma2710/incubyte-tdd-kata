import 'package:test/test.dart';
import '../lib/string_calculator.dart';

void main() {
  group('StringCalculator', () {
    late StringCalculator calculator;

    setUp(() {
      calculator = StringCalculator();
    });

    test('should return 0 for empty string', () {
      expect(calculator.add(''), equals(0));
    });

    test('should return the number itself for single number', () {
      expect(calculator.add('1'), equals(1));
    });

    test('should return sum of two comma-separated numbers', () {
      expect(calculator.add('1,5'), equals(6));
    });

    test('should handle any amount of numbers', () {
      expect(calculator.add('1,2,3,4,5'), equals(15));
      expect(calculator.add('10,20,30'), equals(60));
    });

    test('should handle new lines between numbers', () {
      expect(calculator.add('1\n2,3'), equals(6));
      expect(calculator.add('1\n2\n3'), equals(6));
    });

    test('should support custom delimiters', () {
      expect(calculator.add('//;\n1;2'), equals(3));
      expect(calculator.add('//*\n1*2*3'), equals(6));
    });

    test('should throw exception for negative numbers', () {
      expect(() => calculator.add('-1'), 
        throwsA(predicate((e) => e.toString().contains('negative numbers not allowed -1'))));
      
      expect(() => calculator.add('1,-2,3'), 
        throwsA(predicate((e) => e.toString().contains('negative numbers not allowed -2'))));
    });

    test('should show all negative numbers in exception message', () {
      expect(() => calculator.add('-1,-2,3,-4'), 
        throwsA(predicate((e) => e.toString().contains('negative numbers not allowed -1,-2,-4'))));
    });

    test('should track how many times add was called', () {
      StringCalculator freshCalculator = StringCalculator();
      expect(freshCalculator.getCalledCount(), equals(0));
      
      freshCalculator.add('1');
      expect(freshCalculator.getCalledCount(), equals(1));
      
      freshCalculator.add('1,2');
      expect(freshCalculator.getCalledCount(), equals(2));
      
      freshCalculator.add('//;\n1;2');
      expect(freshCalculator.getCalledCount(), equals(3));
    });
  });
}
