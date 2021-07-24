  import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = 'd8087ea18bdcfa8998e5e1894411f1ed';

class NetworkHelper {
  // final String url;
  final double lat;
  final double long;
  NetworkHelper(this.lat,this.long);

  Future getCityWeather(String cityName) async
  {
    http.Response cityResponse = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
    if(cityResponse.statusCode==200) {
      String data = cityResponse.body;
      return jsonDecode(data);
    }
    else{
      print(cityResponse.statusCode);
    }
  }
  Future getData() async {
    http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric'));
    if(response.statusCode==200) {
      String data = response.body;
      return jsonDecode(data);
    }
    else{
      print(response.statusCode);
    }
  }
}