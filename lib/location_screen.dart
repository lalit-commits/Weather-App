import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weacther_app/weather.dart';
import 'city_screen.dart';
import 'loading_screen.dart';
import 'constants.dart';
import 'networking.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String cityName;
  late int condition;
  late double temp;
  late int temperature;
  late String description;
  late int humidity;
  late int visibility;
  late double windSpeed;
  late Color bgColor;
  late String weatherIcon;
  late String weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI(dynamic weatherData)
  {
    setState(() {
      if(weatherData==null)
        {
          temperature=0;
          weatherIcon='Error';
          weatherMessage='Unable to get weather data';
          cityName='';
          return;
        }

    temp = weatherData['main']['temp'];
     temperature = temp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    description = weatherData['weather'][0]['description'];
    windSpeed =weatherData['wind']['speed'];
    humidity = weatherData['main']['humidity'];
    visibility =weatherData['visibility'];
    weatherIcon = weatherModel.getWeatherIcon(condition);
    weatherMessage = '${weatherModel.getMessage(temperature)} in $cityName';
    bgColor = weatherModel.getThemedColor(temperature);
    print(bgColor);
    print(temperature);
    print(condition);
    print(cityName);
    });

  }
  WeatherModel weatherModel = WeatherModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          // image: DecorationImage(
          //   image: AssetImage('images/location_background.jpg'),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //       Colors.white.withOpacity(0.8), BlendMode.dstATop),
          // ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingScreen()));

                      },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                     var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                       return CityScreen();
                      },
                      ),
                      );
                     print(typedName);
                     if(typedName!=null)
                       {
                         NetworkHelper cityNetworkHelper = NetworkHelper(0,0);
                         var cityWeather= await cityNetworkHelper.getCityWeather(typedName);
                         print(cityWeather);

                         updateUI(cityWeather);
                     //     // Navigator.push(context, MaterialPageRoute(builder: (context){
                     //     //   return LocationScreen(locationWeather: cityWeather,);
                     //     // }));
                       }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),

              Expanded(child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 20),
                child: Material(
                  color: Colors.blueAccent.shade400,
                  borderRadius: BorderRadius.circular(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    Text(
                          '$temperature°',
                          style: GoogleFonts.merriweather(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(description,
                      style: GoogleFonts.satisfy(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      )
                        ,),
                    ],
                  ),
                ),
              ),),

              Row(
                children: <Widget> [
                  Expanded(child:WeatherDetail(property: 'Humidity', propertyVal: '${humidity.toString()} %')),
                  Expanded(child:WeatherDetail(property: 'Wind Speed', propertyVal: '${windSpeed.toString()} m/s')),
                  Expanded(child:WeatherDetail(property: 'Visibility', propertyVal: '${visibility.toString()} m')),

                    ],
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Material(
                  elevation: 10,
                  color: Colors.blueAccent.shade400,
                  borderRadius: BorderRadius.circular(20),
                  child: Text(
                    weatherMessage,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.satisfy(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  WeatherDetail({required this.property,required this.propertyVal});
  final String property;
  final String propertyVal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(

          color: Colors.blueAccent.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(property,
            style: GoogleFonts.satisfy(
              fontSize: 28,
              fontWeight: FontWeight.w800,
            )
            ),
            SizedBox(
              height: 8,
            ),
            Text(propertyVal,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
    );
  }
}
