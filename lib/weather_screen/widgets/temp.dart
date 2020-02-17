import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';

class Temp extends StatelessWidget {
  Temp(this.weatherData, {Key key}) : super(key: key);

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height*0.6,
      left: 20,
      child: Observer(
        builder: (_){
          if(weatherData.data!=null)
            return Text("${weatherData.data["results"]["temp"].toString()}°", style: TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black54, offset: Offset(1.0,1.0))]));              
          else
            return Text("");
        },
      )
    );
  }
}
