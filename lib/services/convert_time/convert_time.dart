import 'package:intl/intl.dart';

String convertTime(String time) {
  final date = DateTime.parse(time);
  final formatter = DateFormat('HH:mm:ss');
  final formattedDate = formatter.format(date.toUtc().add(Duration(hours: 7)));
  return formattedDate;
}
