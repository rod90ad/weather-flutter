import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';
import 'package:weather/weather_screen/widgets/background.dart';
import 'package:weather/weather_screen/widgets/calendar_infos.dart';
import 'package:weather/weather_screen/widgets/city_name.dart';
import 'package:weather/weather_screen/widgets/rotated_icons.dart';
import 'package:weather/weather_screen/widgets/temp.dart';
import 'package:weather/weather_screen/widgets/weather_decoration.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final WeatherData weatherData = WeatherData();
  
  @override
  void initState() {
    super.initState();
    _delay();
  }

  void _delay(){
    Timer.periodic(Duration(minutes: 1), (timer) {
      weatherData.getData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_){
          if(weatherData.data!=null){
            return Stack(
              children: <Widget>[
                Background(weatherData),
                Sun(weatherData),
                SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Temp(weatherData),
                      CalendarInfos(weatherData),
                      CityName(weatherData),
                      RotatedIcons(weatherData),
                    ],
                  ),
                )
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}