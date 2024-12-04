import 'utils.dart';

int processTokens(List<String> tokens) {
  final products = tokens.map((token) {
    token = token.replaceRange(0, 4, '');
    token = token.replaceRange(token.length - 1, null, '');
    final int product = token
        .split(',')
        .map((e) => int.parse(e))
        .reduce((value, element) => value * element);
    return product;
  }).toList();
  return products.reduce((value, element) => value + element);
}

Future<void> main() async {
  final input = await readInputFile('day3_input.txt');

  final tokens = <String>[];
  var tokenBuilder = '';
  var conditionalBuilder = '';
  var shouldParse = true;

  final initialMatcher = r'mul\(\d+';
  var matchBuilder = initialMatcher;

  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    final charIsNumeric = int.tryParse(char) != null;

    if (shouldParse == false) {
      if ((conditionalBuilder.isEmpty && char == 'd') ||
          (conditionalBuilder == 'd' && char == 'o') ||
          (conditionalBuilder == 'do' && char == '(')) {
        conditionalBuilder += char;
      } else if (conditionalBuilder == 'do(' && char == ')') {
        shouldParse = true;
        conditionalBuilder = '';
      } else {
        conditionalBuilder = '';
      }
    } else if ((conditionalBuilder.isEmpty && char == 'd') ||
        (conditionalBuilder == 'd' && char == 'o') ||
        (conditionalBuilder == 'do' && char == 'n') ||
        (conditionalBuilder == 'don' && char == '\'') ||
        (conditionalBuilder == 'don\'' && char == 't') ||
        (conditionalBuilder == 'don\'t' && char == '(')) {
      conditionalBuilder += char;
    } else if (conditionalBuilder == 'don\'t(' && char == ')') {
      shouldParse = false;
      conditionalBuilder = '';
    } else {
      conditionalBuilder = '';
    }

    if (shouldParse == false) {
      continue;
    }

    if ((tokenBuilder.isEmpty && char == 'm') ||
        (tokenBuilder == 'm' && char == 'u') ||
        (tokenBuilder == 'mu' && char == 'l') ||
        (tokenBuilder == 'mul' && char == '(') ||
        (tokenBuilder == 'mul(' && charIsNumeric) ||
        (RegExp(matchBuilder).hasMatch(tokenBuilder) && charIsNumeric)) {
      tokenBuilder += char;
    } else if (RegExp(matchBuilder).hasMatch(tokenBuilder) && char == ',') {
      matchBuilder += char;
      tokenBuilder += char;
    } else if (RegExp(matchBuilder).hasMatch(tokenBuilder) && charIsNumeric) {
      matchBuilder += '\d+';
      tokenBuilder += char;
    } else if (matchBuilder.contains(',') &&
        RegExp(matchBuilder).hasMatch(tokenBuilder) &&
        char == ')') {
      tokenBuilder += char;
      tokens.add(tokenBuilder);
      tokenBuilder = '';
      matchBuilder = initialMatcher;
    } else {
      tokenBuilder = '';
      matchBuilder = initialMatcher;
    }
  }
  print(processTokens(tokens));
  print(tokens.contains('mul(945)'));
}
