import 'package:flutter/material.dart';
import 'package:weather/mobx/weather_data.dart';
import 'package:weather/weather_screen/weather.dart';
import 'package:weather/weather_screen/widgets/open_menu.dart';

class SelectCity extends StatefulWidget {
  SelectCity(this.data, this.weatherState);

  final WeatherData data;
  final WeatherState weatherState;

  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_opacity.value != 0.0) {
      return Positioned(
        right: 5,
        top: 50,
        child: Opacity(
          opacity: _opacity.value,
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.keyboard_arrow_right, size: 35),
            onPressed: () {
              _controller.forward();
            },
          ),
        ),
      );
    } else {
      return OpenMenu(widget.data, _controller, widget.weatherState);
    }
  }
}
