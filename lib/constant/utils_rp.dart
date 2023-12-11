import 'package:intl/intl.dart';

String rupiah(String amount) {
  final formatter = NumberFormat("#,###,##0");
  return 'Rp. ' + formatter.format(double.parse(amount));
}

// String duet(String amount) {
//   final formatter = NumberFormat("#,###,##0");
//   return formatter.format(double.parse(amount));
// }

String duet(String amount) {
  try {
    final formatter = NumberFormat("#,###,##0");
    double parsedAmount = double.parse(amount);
    return formatter.format(parsedAmount);
  } catch (e) {
    // print('Error parsing double: $e');
    return '0';
  }
}