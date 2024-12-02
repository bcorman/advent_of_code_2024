import 'dart:io';

/// Reads the contents of a file and returns it as a single string
Future<String> readInputFile(String fileName) async {
  final file = File(fileName);
  try {
    return await file.readAsString();
  } catch (e) {
    throw Exception('Failed to read input file: $fileName\nError: $e');
  }
}

/// Reads the contents of a file and returns a list of lines
Future<List<String>> readInputFileLines(String fileName) async {
  final contents = await readInputFile(fileName);
  final lines =
      contents.split('\n').where((line) => line.trim().isNotEmpty).toList();
  return lines;
}

/// Reads each line of the file and returns a list of numbers
List<List<num>> readNumbersFromLines(List<String> lines) =>
    lines.map((e) => e.split(RegExp(r'\s+')).map(int.parse).toList()).toList();

/// Reads each list of two numbers and returns two lists of numbers
(List<num>, List<num>) readTwoListsOfNumbers(List<List<num>> lines) {
  final firstList = <num>[];
  final secondList = <num>[];
  lines.forEach((line) {
    if (line.length != 2) {
      throw Exception('Invalid line: $line');
    }
    firstList.add(line[0]);
    secondList.add(line[1]);
  });
  return (firstList, secondList);
}
