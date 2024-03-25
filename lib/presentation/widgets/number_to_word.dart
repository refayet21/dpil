class NumberToWords {
  NumberToWords._();

  static const String _unionSeparator = '-';
  static const String _zero = 'zero'; //0
  static const String _hundred = 'hundred'; //100
  static const String _thousand = 'thousand'; //1000
  static const String _million = 'million'; //1000 000
  static const String _billion = 'billion'; //1000 000 000

  static const List<String> _numNames = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen'
  ];

  static const List<String> _tensNames = [
    '',
    'ten',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety'
  ];

  static String _convertLessThanOneThousand(num number,
      [bool isLastThreeDigits = false]) {
    String soFar = '';

    if ((number % 100).toInt() < 20) {
      soFar = _numNames[(number % 100).toInt()];
      number = (number ~/ 100);
    } else {
      final int numFirst = number.toInt();
      soFar = _numNames[(number.toInt() % 10)];
      number = (number ~/ 10);
      final String unionSeparator =
          (((number ~/ 10).toInt() != 0 && numFirst % 10 != 0) ||
                  (numFirst % 10 != 0 && numFirst < 100))
              ? _unionSeparator
              : '';
      soFar = _tensNames[(number.toInt() % 10)] + unionSeparator + soFar;
      number = (number ~/ 10);
    }
    if (number == 0) {
      return soFar;
    }
    return _numNames[number.toInt()] + ' $_hundred ' + soFar;
  }

  static String convert(num number) {
    if (number == 0) {
      return _zero;
    }
    String result = '';

    final wholePart = number.toInt();
    final fractionalPart = number - wholePart;

    if (wholePart != 0) {
      final String strWholePart = wholePart.toString().padLeft(12, '0');
      final int billions = int.parse(strWholePart.substring(0, 3));
      final int millions = int.parse(strWholePart.substring(3, 6));
      final int hundredThousands = int.parse(strWholePart.substring(6, 9));
      final int thousands = int.parse(strWholePart.substring(9, 12));

      result += _getBillions(billions);
      result += _getMillions(millions);
      result += _getThousands(hundredThousands);

      String tradThousand;
      tradThousand = _convertLessThanOneThousand(thousands, true);
      result += tradThousand;

      result = result
          .replaceAll(RegExp('\\s+'), ' ')
          .replaceAll('\\b\\s{2,}\\b', ' ');
    }

    if (fractionalPart != 0) {
      result += ' point ';
      String strFractionalPart = fractionalPart
          .toStringAsFixed(2)
          .substring(2); // Removing '0.' from the fractional part
      for (int i = 0; i < strFractionalPart.length; i++) {
        result += _numNames[int.parse(strFractionalPart[i])];
        if (i < strFractionalPart.length - 1) {
          result += ' ';
        }
      }
    }

    return result.trim();
  }

  static String _getBillions(int billions) {
    String tradBillions;
    switch (billions) {
      case 0:
        tradBillions = '';
        break;
      case 1:
        tradBillions = _convertLessThanOneThousand(billions) + ' $_billion ';
        break;
      default:
        tradBillions = _convertLessThanOneThousand(billions) + ' $_billion ';
    }
    return tradBillions;
  }

  static String _getMillions(int millions) {
    String tradMillions;
    switch (millions) {
      case 0:
        tradMillions = '';
        break;
      case 1:
        tradMillions = _convertLessThanOneThousand(millions) + ' $_million ';
        break;
      default:
        tradMillions = _convertLessThanOneThousand(millions) + ' $_million ';
    }
    return tradMillions;
  }

  static String _getThousands(int hundredThousands) {
    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = '';
        break;
      case 1:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + ' $_thousand ';
        break;
      default:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + ' $_thousand ';
    }

    return tradHundredThousands;
  }
}
