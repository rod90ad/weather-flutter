import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';
import 'package:weather_icons/weather_icons.dart';

class RotatedIcons extends StatefulWidget {
  RotatedIcons(this.weatherData, {Key key}) : super(key: key);

  final WeatherData weatherData;

  @override
  _RotatedIconsState createState() => _RotatedIconsState();
}

class _RotatedIconsState extends State<RotatedIcons>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation rotateCurve;
  Animation<double> _rotation;

  double ringDiameter;
  final double _iconSize = 30;
  final Color _iconColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    rotateCurve = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeInOutCirc));
    _rotation = Tween<double>(begin: 1.0, end: 95.0).animate(rotateCurve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    ringDiameter = MediaQuery.of(context).size.width * 1.3;
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.435,
        left: 20,
        child: Observer(
          builder: (_) {
            if (widget.weatherData.data != null) {
              return Material(
                child: Container(
                  child: Transform.rotate(
                    angle: (math.pi / _rotation.value),
                    child: Stack(
                        alignment: Alignment.center,
                        children: _applyTranslations(_getIcons())),
                  ),
                ),
                color: Colors.transparent,
              );
            } else {
              return Container();
            }
          },
        ));
  }

  List<Widget> _getIcons() {
    List<Widget> list = List<Widget>();
    list.add(_getIcon(_getTimeIcon(), widget.weatherData.data["results"]["time"], widget.weatherData.data["results"]["description"]));
    list.add(_getIcon(WeatherIcons.sunset, widget.weatherData.data["results"]["sunset"], "Por do Sol"));
    list.add(_getIcon(WeatherIcons.windy, widget.weatherData.data["results"]["wind_speedy"], "Vento"));
    list.add(_getIcon(WeatherIcons.sunrise, widget.weatherData.data["results"]["sunrise"], "Nascer do Sol"));
    list.add(_getIcon(WeatherIcons.humidity, "${widget.weatherData.data["results"]["humidity"].toString()}%", "Umidade do Ar"));    
    return list;
  }

  Widget _getIcon(IconData iconData, String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BoxedIcon(iconData, color: _iconColor, size: _iconSize),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            Text(subTitle, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        )
      ]
    );
  }

  IconData _getTimeIcon() {
    switch (
        widget.weatherData.data["results"]["time"].toString().split(":")[0]) {
      case "12":
      case "00":
        return WeatherIcons.time_12;
      case "01":
      case "13":
        return WeatherIcons.time_1;
      case "02":
      case "14":
        return WeatherIcons.time_2;
      case "03":
      case "15":
        return WeatherIcons.time_3;
      case "04":
      case "16":
        return WeatherIcons.time_4;
      case "05":
      case "17":
        return WeatherIcons.time_5;
      case "06":
      case "18":
        return WeatherIcons.time_6;
      case "07":
      case "19":
        return WeatherIcons.time_7;
      case "08":
      case "20":
        return WeatherIcons.time_8;
      case "09":
      case "21":
        return WeatherIcons.time_9;
      case "10":
      case "22":
        return WeatherIcons.time_10;
      case "11":
      case "23":
        return WeatherIcons.time_11;
      default:
        return WeatherIcons.time_2;
    }
  }

  List<Widget> _applyTranslations(List<Widget> widgets) {
    return widgets
        .asMap()
        .map((index, widget) {
          final double angle = widgets.length == 1
              ? 45.0
              : 90.0 / (widgets.length * 2 - 2) * (index * 2) - 45;
          return MapEntry(index, _applyTranslation(angle, widget));
        })
        .values
        .toList();
  }

  Widget _applyTranslation(double angle, Widget widget) {
    final double rad = vector.radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate((ringDiameter / 2) * math.cos(rad),
            (ringDiameter / 2) * math.sin(rad)),
      child: Transform(
        child: widget,
        transform: Matrix4.rotationZ(-math.pi / _rotation.value),
        alignment: FractionalOffset.center,
      ),
    );
  }
}
