class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    
    String delimiter = ',';
    String numbersToProcess = numbers;
    
    // Check for custom delimiter
    if (numbers.startsWith('//')) {
      int delimiterEndIndex = numbers.indexOf('\n');
      delimiter = numbers.substring(2, delimiterEndIndex);
      numbersToProcess = numbers.substring(delimiterEndIndex + 1);
    }
    
    // Replace newlines with commas, then replace custom delimiter with commas
    String normalizedNumbers = numbersToProcess.replaceAll('\n', ',');
    if (delimiter != ',') {
      normalizedNumbers = normalizedNumbers.replaceAll(delimiter, ',');
    }
    
    List<String> numberList = normalizedNumbers.split(',');
    List<int> negativeNumbers = [];
    int sum = 0;
    
    for (String number in numberList) {
      if (number.isNotEmpty) {
        int parsedNumber = int.parse(number.trim());
        if (parsedNumber < 0) {
          negativeNumbers.add(parsedNumber);
        } else {
          sum += parsedNumber;
        }
      }
    }
    
    if (negativeNumbers.isNotEmpty) {
      String negativeNumbersStr = negativeNumbers.join(',');
      throw Exception('negative numbers not allowed $negativeNumbersStr');
    }
    
    return sum;
  }
}
