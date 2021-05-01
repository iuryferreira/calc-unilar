class MoneyInputValidator {

  static toDouble(String text) {

    text = text.replaceAll(".", '');
    text = text.replaceAll(",", '.');

  }

  static validate(String inputText) {

    if(!isGreaterThanZero(toDouble(inputText))){

      return "O valor não pode ser zero.";

    }
    return true;
  }

  static isGreaterThanZero(double value) {
    return value > 0.0 ? true : false;
  }

  static isGreaterThan(double value, comparativeValue) {
    return value > comparativeValue ? true : false;
  }
}
