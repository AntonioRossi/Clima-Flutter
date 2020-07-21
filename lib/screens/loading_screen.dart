import 'package:flutter/material.dart';

import 'package:clima/services/location.dart';
import "package:clima/services/networking.dart";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var data;

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
    getLocationData();

    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Get Location'),
          onPressed: () {},
        ),
      ),
    );
  }
}
