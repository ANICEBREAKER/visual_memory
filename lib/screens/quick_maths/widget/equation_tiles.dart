class EquationTiles {
  final int firstNumber;
  final int secondNumber;
  final String operator;

  EquationTiles({required this.firstNumber, required this.secondNumber, required this.operator});

  int compute() {
    switch (operator) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      case '×':
      case '*':
        return firstNumber * secondNumber;
      default:
        return 0;
    }
  }
}