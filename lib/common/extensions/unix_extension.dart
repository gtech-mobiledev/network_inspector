import 'package:intl/intl.dart';

extension UnixExtension on int? {
  String? get convertToYmdHms {
    if (this != null) {
      var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      var dateTime = DateTime.fromMillisecondsSinceEpoch(this!);
      return dateFormat.format(dateTime);
    }
    return null;
  }
}
