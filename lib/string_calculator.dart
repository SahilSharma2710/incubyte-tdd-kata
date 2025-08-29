class StringCalculator {
  int _callCount = 0;
  static const int _maxAllowedNumber = 1000;
  
  int getCalledCount() {
    return _callCount;
  }
  
  int add(String numbers) {
    _callCount++;
    
    if (numbers.isEmpty) {
      return 0;
    }
    
    final delimitersAndNumbers = _parseDelimitersAndNumbers(numbers);
    final normalizedNumbers = _normalizeDelimiters(
      delimitersAndNumbers.numbers, 
      delimitersAndNumbers.delimiters
    );
    final numberList = _splitIntoNumbers(normalizedNumbers);
    
    return _calculateSum(numberList);
  }
  
  DelimitersAndNumbers _parseDelimitersAndNumbers(String input) {
    if (!input.startsWith('//')) {
      return DelimitersAndNumbers([','], input);
    }
    
    final delimiterEndIndex = input.indexOf('\n');
    final delimiterSection = input.substring(2, delimiterEndIndex);
    final numbersToProcess = input.substring(delimiterEndIndex + 1);
    
    final delimiters = _extractDelimiters(delimiterSection);
    return DelimitersAndNumbers(delimiters, numbersToProcess);
  }
  
  List<String> _extractDelimiters(String delimiterSection) {
    if (!delimiterSection.contains('[')) {
      return [delimiterSection];
    }
    
    final delimiters = <String>[];
    final regExp = RegExp(r'\[([^\]]+)\]');
    final matches = regExp.allMatches(delimiterSection);
    
    for (final match in matches) {
      delimiters.add(match.group(1)!);
    }
    
    return delimiters;
  }
  
  String _normalizeDelimiters(String numbers, List<String> delimiters) {
    var normalizedNumbers = numbers.replaceAll('\n', ',');
    
    for (final delimiter in delimiters) {
      if (delimiter != ',') {
        normalizedNumbers = normalizedNumbers.replaceAll(delimiter, ',');
      }
    }
    
    return normalizedNumbers;
  }
  
  List<String> _splitIntoNumbers(String normalizedNumbers) {
    return normalizedNumbers
        .split(',')
        .where((number) => number.isNotEmpty)
        .map((number) => number.trim())
        .toList();
  }
  
  int _calculateSum(List<String> numberStrings) {
    final negativeNumbers = <int>[];
    var sum = 0;
    
    for (final numberString in numberStrings) {
      final number = int.parse(numberString);
      
      if (number < 0) {
        negativeNumbers.add(number);
      } else if (number <= _maxAllowedNumber) {
        sum += number;
      }
      // Numbers > _maxAllowedNumber are ignored
    }
    
    _validateNoNegativeNumbers(negativeNumbers);
    return sum;
  }
  
  void _validateNoNegativeNumbers(List<int> negativeNumbers) {
    if (negativeNumbers.isNotEmpty) {
      final negativeNumbersStr = negativeNumbers.join(',');
      throw Exception('negative numbers not allowed $negativeNumbersStr');
    }
  }
}

class DelimitersAndNumbers {
  final List<String> delimiters;
  final String numbers;
  
  DelimitersAndNumbers(this.delimiters, this.numbers);
}
