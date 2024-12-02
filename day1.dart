import 'utils.dart';

num getSumOfDistances(List<num> firstList, List<num> secondList) {
  final distances = <num>[];
  for (var i = 0; i < firstList.length; i++) {
    final distance = (firstList[i] - secondList[i]).abs();
    distances.add(distance);
  }
  return distances.reduce((a, b) => a + b);
}

num getSimilarityScore(List<num> firstList, List<num> secondList) {
  final scores = <num>[];
  for (var i = 0; i < firstList.length; i++) {
    final number = firstList[i];
    final score =
        number * secondList.where((element) => element == number).length;
    scores.add(score);
  }
  return scores.reduce((a, b) => a + b);
}

void main() async {
  final List<String> contents = await readInputFileLines('day1_input.txt');
  final List<List<num>> numbers = readNumbersFromLines(contents);

  final (firstList, secondList) = readTwoListsOfNumbers(numbers);
  firstList.sort();
  secondList.sort();

  // Part 1 - Get the sum of the distances
  final sumOfDistances = getSumOfDistances(firstList, secondList);
  print(sumOfDistances);

  // Part 2 - Get the similarity score
  final similarityScore = getSimilarityScore(firstList, secondList);
  print(similarityScore);
}
