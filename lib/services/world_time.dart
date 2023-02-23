import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {

  String location; // location name for the ui
  String? time; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool? isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {
      final response = await http.get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1,3);
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(now); 

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false; 
    }
    catch (e) {
      print('catch error: $e');
      time = 'could not get the time data';
    } 
  }
}

