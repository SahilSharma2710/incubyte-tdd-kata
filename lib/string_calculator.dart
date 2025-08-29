class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    
    // Replace newlines with commas, then split by comma and sum all numbers
    String normalizedNumbers = numbers.replaceAll('\n', ',');
    List<String> numberList = normalizedNumbers.split(',');
    int sum = 0;
    for (String number in numberList) {
      sum += int.parse(number.trim());
    }
    return sum;
  }
}
