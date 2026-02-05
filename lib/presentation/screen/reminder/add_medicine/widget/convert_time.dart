import 'package:intl/intl.dart';

List<String> convertTimes(List<String> times) {
  final inputFormat = DateFormat("h:mm a");
  final outputFormat = DateFormat("HH:mm");

  return times.map((time) {
    final date = inputFormat.parse(time);
    return outputFormat.format(date);
  }).toList();
}
