import 'utils.dart';

int searchPartOne(List<String> input) {
  var count = 0;

  for (var l = 0; l < input.length; l++) {
    final line = input[l];
    for (var c = 0; c < input.length; c++) {
      final char = line[c];
      final letters = ['M', 'A', 'S'];

      if (char == 'X') {
        var left = 'X';
        var right = 'X';
        var up = 'X';
        var down = 'X';
        var upLeft = 'X';
        var upRight = 'X';
        var downLeft = 'X';
        var downRight = 'X';

        for (var letter in letters) {
          final letterIndex = letters.indexOf(letter) + 1;
          final upIndex = l - letterIndex;
          final downIndex = l + letterIndex;
          final leftIndex = c - letterIndex;
          final rightIndex = c + letterIndex;
          bool canLookUp = 0 <= upIndex;
          bool canLookDown = downIndex < input.length;
          bool canLookLeft = 0 <= leftIndex;
          bool canLookRight = rightIndex < line.length;

          if (canLookLeft) {
            final leftChar = line[leftIndex];
            if (leftChar == letter) {
              left += leftChar;
              if (left == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookRight) {
            final rightChar = line[rightIndex];
            if (rightChar == letter) {
              right += rightChar;
              if (right == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookUp) {
            final upChar = input[upIndex][c];
            if (upChar == letter) {
              up += upChar;
              if (up == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookDown) {
            final downChar = input[downIndex][c];
            if (downChar == letter) {
              down += downChar;
              if (down == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookUp && canLookLeft) {
            final upLeftChar = input[upIndex][leftIndex];
            if (upLeftChar == letter) {
              upLeft += upLeftChar;
              if (upLeft == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookUp && canLookRight) {
            final upRightChar = input[upIndex][rightIndex];
            if (upRightChar == letter) {
              upRight += upRightChar;
              if (upRight == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookDown && canLookLeft) {
            final downLeftChar = input[downIndex][leftIndex];
            if (downLeftChar == letter) {
              downLeft += downLeftChar;
              if (downLeft == 'XMAS') {
                count++;
              }
            }
          }

          if (canLookDown && canLookRight) {
            final downRightChar = input[downIndex][rightIndex];
            if (downRightChar == letter) {
              downRight += downRightChar;
              if (downRight == 'XMAS') {
                count++;
              }
            }
          }
        }
      }
    }
  }
  return count;
}

int searchPartTwo(List<String> input) {
  var count = 0;
  for (var l = 0; l < input.length; l++) {
    final line = input[l];
    for (var c = 0; c < input.length; c++) {
      bool canLookUp = 0 <= l - 1;
      bool canLookDown = l + 1 < input.length;
      bool canLookLeft = 0 <= c - 1;
      bool canLookRight = c + 1 < line.length;

      if ((canLookRight && canLookLeft && canLookUp && canLookDown) &&
          line[c] == 'A') {
        final candidates = [];
        // Grab all diagonal neighbors.
        candidates.addAll([
          // up-left
          input[l - 1][c - 1],
          // up-right
          input[l - 1][c + 1],
          // down-left
          input[l + 1][c - 1],
          // down-right
          input[l + 1][c + 1],
        ]);
        // Check that list has 2 M's and S's
        if (candidates.where((element) => element == 'M').length == 2 &&
            candidates.where((element) => element == 'S').length == 2) {
          // Check against invalid placement, e.g.
          // M_S
          // _A_
          // S_M
          // which would produce a list like [M,S,S,M]
          if (candidates.first != candidates.last) {
            count++;
          }
        }
      }
    }
  }
  return count;
}

Future<void> main() async {
  final input = await readInputFileLines('day4_input.txt');
  print(searchPartOne(input));
  print(searchPartTwo(input));
}
