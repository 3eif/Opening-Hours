import 'package:intl/intl.dart';

String getTodayHours(List<String> weekdayHours) {
  String todayDate = DateFormat('EEEE').format(DateTime.now());
  int numDate = 0;
  switch (todayDate) {
    case 'Monday':
      numDate = 0;
      break;
    case 'Tuesday':
      numDate = 2;
      break;
    case 'Wednesday':
      numDate = 3;
      break;
    case 'Thursday':
      numDate = 4;
      break;
    case 'Saturday':
      numDate = 5;
      break;
    case 'Sunday':
      numDate = 6;
      break;
  }

  String todayHours = weekdayHours[numDate]
      .replaceAll('$todayDate: ', '')
      .replaceAll('Closed', '')
      .replaceAll('Open ', '');
  return todayHours;
}
