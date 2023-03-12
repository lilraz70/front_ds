import '../constants/days_of_week.dart';
import '../constants/months_of_year.dart';

String customDateFormat(date) {
  return "${DateTime.parse(date).day} ${monthsOfYear[DateTime.parse(date).month]!.toLowerCase()} "
      "${DateTime.parse(date).year}";
}