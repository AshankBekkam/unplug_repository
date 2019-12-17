

class EuDateTime{

  DateTime dateTime;
  int hour; String minute;
  String hourMinute;
  String suffix;
  String day;String month;String year;
  String dayOfWeek;
  String euDateTime;

  EuDateTime(this.dateTime)
  {
    day = dateTime.day.toString();
    month = dateTime.month.toString();
    year = dateTime.year.toString();
    hour = dateTime.hour;
    minute = dateTime.minute.toString();
    suffix = 'AM';
    if(dateTime.day < 10)
      day = '0'+day;
    if(dateTime.month<10)
      month = '0'+month;
    if(dateTime.minute<10)
      minute = '0'+minute;

    if(hour>12) {
      hour = hour % 12;
      suffix = 'PM';
    }



  }

  String getDate()
  {


    return('$day-$month-$year');
  }
  String getTime()
  {

    return('$hour:$minute $suffix');


  }

  String getDateTime()
  {
    return('$day-$month-$year'+'   $hour:$minute $suffix');

  }



}