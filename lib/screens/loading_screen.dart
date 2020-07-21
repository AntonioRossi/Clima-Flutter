import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    var data;

    double temperature;
    int weatherCondition;
    String city;

    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');
    if (response.statusCode == 200) {
      print(response.body);

      data = response.body;

      var decodedData = jsonDecode(data);

      temperature = decodedData['main']['temp'];
      weatherCondition = decodedData['weather'][0]['id'];
      city = decodedData['name'];

      print(temperature);
      print(weatherCondition);
      print(city);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Get Location'),
          onPressed: () {
            getLocation();
          },
        ),
      ),
    );
  }
}
