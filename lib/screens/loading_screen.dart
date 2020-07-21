import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import "package:clima/services/networking.dart";
import 'package:clima/screens/location_screen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var data;

  final spinkit = SpinKitDoubleBounce(
    color: Colors.white,
    size: 150.0,
  );

  void getLocationData() async {
    Location location = Location();
    await location.getLocation();
    print(location.latitude);
    print(location.longitude);

    NetworkHelper networkHelper = NetworkHelper(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    data = await networkHelper.getData();
    print(data);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen();
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
