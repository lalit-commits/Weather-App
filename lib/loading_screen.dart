import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location.dart';
import 'networking.dart';

const apiKey = 'd8087ea18bdcfa8998e5e1894411f1ed';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getLoc();

  }
  void getLoc() async
  {
    Location location =Location();
    await location.getCurrentLoc();

    NetworkHelper networkHelper = NetworkHelper(location.lat,location.long);
    var weather = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weather,);
    }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size:100.0,
        ),
      ),
    );
  }
}
