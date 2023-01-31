import 'package:intl/intl.dart';

String dateConverter(String date) {
  var formattedDate =
      DateFormat('dd-MM-yyyy HH:mm a').format(DateTime.parse(date));
  return formattedDate.toString();
}
