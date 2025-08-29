class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    
    // Split by comma and sum all numbers
    List<String> numberList = numbers.split(',');
    int sum = 0;
    for (String number in numberList) {
      sum += int.parse(number.trim());
    }
    return sum;
  }
}
