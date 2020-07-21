import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';

class NetworkHelper {
  var data;
  double latitude;
  double longitude;

  NetworkHelper({@required this.latitude, @required this.longitude});

  Future loadEnvironment() async {
    await FlutterConfig.loadEnvVariables();
  }

  Future getData() async {
    await loadEnvironment();

    String apiKey = FlutterConfig.get('OPENWEATHERMAP_API_KEY');

    String request =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';

    http.Response response = await http.get(request);
    if (response.statusCode == 200) {
      print(response.body);

      data = response.body;

      var decodedData = jsonDecode(data);

      var temperature = decodedData['main']['temp'];
      var weatherCondition = decodedData['weather'][0]['id'];
      var city = decodedData['name'];

      print(temperature);
      print(weatherCondition);
      print(city);

      return data;
    } else {
      print(response);
      return null;
    }
  }
}
