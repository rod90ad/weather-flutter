import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';

class Background extends StatelessWidget {
  Background(this.weatherData, {Key key}) : super(key: key);

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      switch (weatherData.data["results"]["condition_slug"].toString()) {
        case "rain":
          return Opacity(
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/rain.gif"),
                          alignment: Alignment.topRight,
                          fit: BoxFit.fitHeight,
                          colorFilter: ColorFilter.mode(
                              Colors.blue[700], BlendMode.overlay)))),
              opacity: 1);
        default:
          return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/sunny.jpg"),
                      alignment: Alignment.topRight,
                      fit: BoxFit.fitHeight,
                      colorFilter: ColorFilter.mode(
                          Colors.orange[100], BlendMode.overlay))));
      }
    });
  }
}
