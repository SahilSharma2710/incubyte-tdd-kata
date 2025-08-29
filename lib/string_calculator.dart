class StringCalculator {
  int _callCount = 0;
  
  int getCalledCount() {
    return _callCount;
  }
  
  int add(String numbers) {
    _callCount++;
    if (numbers.isEmpty) {
      return 0;
    }
    
    List<String> delimiters = [','];
    String numbersToProcess = numbers;
    
    // Check for custom delimiter(s)
    if (numbers.startsWith('//')) {
      int delimiterEndIndex = numbers.indexOf('\n');
      String delimiterSection = numbers.substring(2, delimiterEndIndex);
      
      // Parse multiple delimiters in brackets format //[delim1][delim2]
      if (delimiterSection.contains('[')) {
        delimiters = [];
        RegExp regExp = RegExp(r'\[([^\]]+)\]');
        Iterable<RegExpMatch> matches = regExp.allMatches(delimiterSection);
        for (RegExpMatch match in matches) {
          delimiters.add(match.group(1)!);
        }
      } else {
        delimiters = [delimiterSection];
      }
      
      numbersToProcess = numbers.substring(delimiterEndIndex + 1);
    }
    
    // Replace newlines with commas, then replace all custom delimiters with commas
    String normalizedNumbers = numbersToProcess.replaceAll('\n', ',');
    for (String delimiter in delimiters) {
      if (delimiter != ',') {
        normalizedNumbers = normalizedNumbers.replaceAll(delimiter, ',');
      }
    }
    
    List<String> numberList = normalizedNumbers.split(',');
    List<int> negativeNumbers = [];
    int sum = 0;
    
    for (String number in numberList) {
      if (number.isNotEmpty) {
        int parsedNumber = int.parse(number.trim());
        if (parsedNumber < 0) {
          negativeNumbers.add(parsedNumber);
        } else if (parsedNumber <= 1000) {
          sum += parsedNumber;
        }
        // Numbers > 1000 are ignored
      }
    }
    
    if (negativeNumbers.isNotEmpty) {
      String negativeNumbersStr = negativeNumbers.join(',');
      throw Exception('negative numbers not allowed $negativeNumbersStr');
    }
    
    return sum;
  }
}
