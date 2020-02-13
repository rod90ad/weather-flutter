import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';
import 'package:weather/weather_screen/widgets/draw_cirle.dart';

class Sun extends StatelessWidget {
  Sun(this.weatherData, {Key key}) : super(key: key);

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.5,
        left: 20,
        child: Observer(
          builder: (_) {
            if (weatherData.data != null)
              if(weatherData.data["results"]["condition_slug"]=="rain"){
                return Container(
                  child: Stack(
                    children: <Widget>[
                      _getCirtle(Colors.blue[900], MediaQuery.of(context).size.width * 0.7, 0.5),
                      _getCirtle(Colors.blue[900], MediaQuery.of(context).size.width * 0.65, 0.55),
                      _getCirtle(Colors.blue[900], MediaQuery.of(context).size.width * 0.6, 0.6),
                      _getCirtle(Colors.blue[900], MediaQuery.of(context).size.width * 0.55, 0.65),
                      _getCirtle(Colors.black87, MediaQuery.of(context).size.width * 0.6, 0.7),
                    ],
                  ),
                );
              }else{
                return Container(
                  child: Stack(
                    children: <Widget>[
                      _getCirtle(Colors.yellow[800], MediaQuery.of(context).size.width * 0.7, 0.6),
                      _getCirtle(Colors.yellow[800], MediaQuery.of(context).size.width * 0.65, 0.7),
                      _getCirtle(Colors.yellow[800], MediaQuery.of(context).size.width * 0.6, 0.8),
                      _getCirtle(Colors.yellow[800], MediaQuery.of(context).size.width * 0.55, 0.9),
                      _getCirtle(Colors.yellow[900], MediaQuery.of(context).size.width * 0.6, 1),
                    ],
                  ),
                );
              }
            else
              return Container(
                child: CustomPaint(painter: DrawCircle(Colors.grey, 100.0)),
              );
          },
        ));
  }

  Widget _getCirtle(Color color, double size, double opacity){
    return Opacity(child: CustomPaint(painter: DrawCircle(color, size)), opacity: opacity);
  }
}
