import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Functions{

    //Date Method
String formatApiDate(String apiDate) {
  try {
    final parsedDate = DateFormat('E, d MMM y H:m:s Z').parse(apiDate);
    return "Last Update: ${DateFormat.yMMMd().add_jm().format(parsedDate)}";
  } catch (e) {
    if (kDebugMode) {
      print("Error parsing date: $e");
    }
    return "Last Update: N/A";
  }
}

}