import 'package:flutter/material.dart';
import 'package:weather/mobx/weather_data.dart';
import 'package:weather/weather_screen/weather.dart';

class OpenMenu extends StatefulWidget {
  OpenMenu(this.data, this.previousController, this.weatherState);

  final WeatherData data;
  final AnimationController previousController;
  final WeatherState weatherState;

  @override
  _OpenMenuState createState() => _OpenMenuState();
}

class _OpenMenuState extends State<OpenMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _appear;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _controller.value = 0.01;
    _appear = Tween<double>(begin: -250.0, end: 0.0).animate(_controller)
      ..addListener(() {
        if (_controller.value == 0.0) widget.previousController.reverse();
        setState(() {});
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: _appear.value,
      top: 0,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height,
          color: widget.data.data["results"]["condition_slug"] == "rain"
              ? Colors.blue[900]
              : Colors.yellow[800],
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              _getAction(Icons.refresh, "Atualizar", () {
                widget.data.getData();
                _controller.reverse();
                widget.weatherState.refresh();
              }),
              Divider(color: Colors.white),
              _getAction(Icons.location_city, "São Paulo", () {
                widget.data.getData(woeid: 455827);
                _controller.reverse();
                widget.weatherState.refresh();
              }),
              Divider(color: Colors.white),
              _getAction(Icons.location_city, "Rio de Janeiro", () {
                widget.data.getData(woeid: 90200707);
                _controller.reverse();
                widget.weatherState.refresh();
              }),
              Divider(color: Colors.white),
              _getAction(Icons.location_city, "Pres. Epitácio", () {
                widget.data.getData(woeid: 456451);
                _controller.reverse();
                widget.weatherState.refresh();
              }),
              Divider(color: Colors.white),
              _getAction(Icons.add, "Adicionar", () {
                print("clicou");
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAction(IconData icon, String text, Function function) {
    return InkWell(
      onTap: function,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                left: 1.0,
                top: 1.0,
                child: Icon(icon, color: Colors.black54, size: 30),
              ),
              Icon(icon, color: Colors.white, size: 30),
            ],
          ),
          Text(text,
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(color: Colors.black54, offset: Offset(1.0, 1.0))
              ]))
        ],
      ),
    );
  }
}
