import 'package:intl/intl.dart';

class UtilsDate {

  static String tanggalHariIni(String format) {
    return DateFormat(format).format(DateTime.now());
  }

  String rupiah(String amount) {
    final formatter = NumberFormat("#,###,##0");
    return 'Rp' + formatter.format(double.parse(amount));
  }

}
