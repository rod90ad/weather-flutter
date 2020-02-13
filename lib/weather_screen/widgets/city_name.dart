import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';

class CityName extends StatelessWidget {
  
  CityName(this.weatherData, {Key key}): super(key:key);

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height*0.08,
      left: 20,
      child: Observer(
        builder: (_){
          if(weatherData.data!=null)
            return Text(weatherData.data["results"]["city"].toString().replaceAll(",", ""), style: TextStyle(color: Colors.white, fontSize: 35));
          else
            return Text("");
        },
      )
    );
  }
}