import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';

import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final spinkit = SpinKitDoubleBounce(
    color: Colors.white,
    size: 150.0,
  );

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var decodedData = await weatherModel.getWeatherData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationData: decodedData);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocationData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
