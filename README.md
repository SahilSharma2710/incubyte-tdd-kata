# String Calculator TDD Kata

A Dart implementation of the String Calculator kata following Test-Driven Development (TDD) principles.

## What is this?

This project implements a string calculator that can add numbers from string input with support for:
- Multiple delimiters (commas, newlines, custom delimiters)
- Negative number validation
- Large number filtering (>1000)
- Usage tracking

## Setup

1. Ensure you have Dart SDK installed
2. Install dependencies:
   ```bash
   dart pub get
   ```

## Running Tests

```bash
# Run all tests
dart test

# Run tests with verbose output
dart test --reporter=expanded
```

## Usage Example

```dart
final calculator = StringCalculator();

calculator.add("");           // Returns 0
calculator.add("1,2,3");      // Returns 6
calculator.add("1\n2,3");     // Returns 6
calculator.add("//;\n1;2");   // Returns 3
calculator.add("//[***]\n1***2***3"); // Returns 6
```

## TDD Implementation

This kata was implemented following strict TDD methodology with 12 incremental steps, each with:
- Red: Write failing test
- Green: Implement minimal code to pass
- Refactor: Clean up code while keeping tests green

Each step is documented in the commit history showing the TDD progression.
