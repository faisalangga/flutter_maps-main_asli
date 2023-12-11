
import 'package:koperasimobile/constant/image_constant.dart';

String getLogoBank(String bank) {
  if (bank == 'BCA Syariah') {
    return ImageConstant.bcasyariah;
  }else{
    return ImageConstant.loading;
  }
}

DateTime addMonths(DateTime dateTime, int monthsToAdd) {
  final newYear = dateTime.year + (dateTime.month + monthsToAdd) ~/ 12;
  final newMonth = (dateTime.month + monthsToAdd) % 12;
  final newDay = dateTime.day;
  final newDate = DateTime(newYear, newMonth-1, newDay);
  return newDate;
}