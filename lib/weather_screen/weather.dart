import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';
import 'package:weather/weather_screen/widgets/background.dart';
import 'package:weather/weather_screen/widgets/calendar_infos.dart';
import 'package:weather/weather_screen/widgets/city_name.dart';
import 'package:weather/weather_screen/widgets/rotated_icons.dart';
import 'package:weather/weather_screen/widgets/select_city.dart';
import 'package:weather/weather_screen/widgets/temp.dart';
import 'package:weather/weather_screen/widgets/weather_decoration.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Weather extends StatefulWidget {
  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  final WeatherData weatherData = WeatherData();
  final GlobalKey<RotatedIconsState> rotatedIconsController =
      GlobalKey<RotatedIconsState>();

  @override
  void initState() {
    super.initState();
    _delay();
  }

  void _delay() {
    Timer.periodic(Duration(minutes: 1), (timer) {
      weatherData.getData();
    });
  }

  void refresh() {
    rotatedIconsController.currentState.controller.value = 0.0;
    rotatedIconsController.currentState.controller.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Scaffold(body: Observer(
      builder: (_) {
        if (weatherData.data != null) {
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
                    RotatedIcons(weatherData, key: rotatedIconsController),
                  ],
                ),
              ),
              SelectCity(weatherData, this),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
