import 'utils.dart';

enum Direction {
  increasing,
  decreasing,
}

bool validateLevelSafety(List<num> level, {bool isAllowedOneFault = false}) {
  var isSafe = true;

  final initialDirection = (level[0] - level[1]).isNegative
      ? Direction.increasing
      : Direction.decreasing;
  for (var i = 1; i < level.length; i++) {
    final difference = level[i - 1] - level[i];
    final currentDirection =
        difference.isNegative ? Direction.increasing : Direction.decreasing;

    if (currentDirection != initialDirection) {
      isSafe = false;
      break;
    }
    if (difference == 0 || difference.abs() > 3) {
      isSafe = false;
      break;
    }
  }

  // If the level is not safe, remove one number at a time and check if the
  // level is now safe.
  if (isSafe == false && isAllowedOneFault) {
    final amendedLevels = <List<num>>[];
    for (var i = 0; i < level.length; i++) {
      final newLevel = [...level];
      newLevel.removeAt(i);

      amendedLevels.add(newLevel);
    }
    var isAmendedSafe = false;
    for (var amendedLevel in amendedLevels) {
      if (validateLevelSafety(amendedLevel)) {
        isAmendedSafe = true;
        break;
      }
    }
    isSafe = isAmendedSafe;
  }
  return isSafe;
}

void main() async {
  final contents = await readInputFileLines('day2_input.txt');
  final levels = readNumbersFromLines(contents);

  // Part 1 - Get the number of safe reports
  var safeReports = 0;
  for (var level in levels) {
    if (validateLevelSafety(level)) {
      safeReports++;
    }
  }
  print(safeReports);

  // Part 2 - Get the number of safe reports with one fault allowed
  var safeReportsWithOneFault = 0;
  for (var level in levels) {
    if (validateLevelSafety(level, isAllowedOneFault: true)) {
      safeReportsWithOneFault++;
    }
  }
  print(safeReportsWithOneFault);
}
