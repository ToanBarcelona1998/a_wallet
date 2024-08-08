import 'package:intl/intl.dart';

class AppDateFormatter {
  static final DateFormat amPm = DateFormat('a');
  static final DateFormat hourMinute = DateFormat('HH:mm');
  static final DateFormat hourMinuteSecond = DateFormat('HH:mm:ss');
  static final DateFormat hourMinuteAmPm = DateFormat('hh:mm a');
  static final DateFormat day = DateFormat('dd');
  static final DateFormat dayMonthYearWithSlash = DateFormat('dd/MM/yyyy');
  static final DateFormat hourMinuteDayMonthYearWithSlash =
      DateFormat('HH:mm dd/MM/yyyy');
  static final DateFormat dayMonthYearWithDot = DateFormat('dd.MM.yyyy');
  static final DateFormat yearMonthDayWithDot = DateFormat('yyyy.MM.dd');
  static final DateFormat yearMonthDayWithHyphen = DateFormat('yyyy-MM-dd');
  static DateFormat yearMonthDayHourMinuteSecond =
      DateFormat('yyyy-MM-dd HH:mm:ss');
  static DateFormat yearMonthDayHourMinute = DateFormat('yyyy-MM-dd HH:mm');
  static final DateFormat dowFullWithDayMonthYear =
      DateFormat('EEEE, dd/MM/yyyy');
  static final DateFormat dowShortWithDayMonthYear =
      DateFormat('EEE, dd/MM/yyyy');
  static final DateFormat dowShort = DateFormat('EEE');
  static final DateFormat monthShort = DateFormat('MMM');
  static final DateFormat monthShortWithYear = DateFormat('MMM yyyy');
}

sealed class AppDateTime {
 static String formatDateTimeHHmmWithAMPM(String dateTimeString){
   late DateTime dateTime;
   if (dateTimeString.lastIndexOf('Z') != -1) {
     dateTime = DateTime.parse(dateTimeString).toLocal();
   }else{
     dateTime = DateTime.parse(dateTimeString);
   }

   return '${AppDateFormatter.hourMinute.format(dateTime)} ${AppDateFormatter.amPm.format(dateTime)}';
 }

 static String formatDateDMMMYYY(String dateTimeString) {
   late DateTime dateTime;
   if (dateTimeString.lastIndexOf('Z') != -1) {
     dateTime = DateTime.parse(dateTimeString).toLocal();
   }else{
     dateTime = DateTime.parse(dateTimeString);
   }


   String dateFormat = "${dateTime.day} ${_getMonthEnName(dateTime.month)} ${dateTime.year}";

   return dateFormat;
 }


  static String formatDateHHMMDMMMYYY(String dateTimeString) {
    late DateTime dateTime;
    if (dateTimeString.lastIndexOf('Z') != -1) {
      dateTime = DateTime.parse(dateTimeString).toLocal();
    }else{
      dateTime = DateTime.parse(dateTimeString);
    }

    // Format the DateTime to "hh:mm, d MMM yyyy"
    String timeFormat = "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
    String dateFormat = "${dateTime.day} ${_getMonthEnName(dateTime.month)} ${dateTime.year}";

    return "$timeFormat, $dateFormat";
  }

  static String _getMonthEnName(int month) {
    // Convert month number to month name
    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return monthNames[month - 1];
  }
}
