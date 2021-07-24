import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,

        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 25),
                child: Material(
                  elevation: 5.0,
                 borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent.shade400,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,

                      ),
                      decoration: kTextFieldInputDecoration,
                      onChanged: (val)
                      {
                        cityName=val;
                      },
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {

                  Navigator.pop(context,cityName);

                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
