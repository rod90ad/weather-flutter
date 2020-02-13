import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather/mobx/weather_data.dart';

class CalendarInfos extends StatelessWidget {
  
  CalendarInfos(this.weatherData,{Key key}):super(key:key);
  
  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height*0.04,
      left: 20,
      child: Observer(
        builder: (_){
          if(weatherData.data!=null)
            return Text(_formatText(), style: TextStyle(color: Colors.white, fontSize: 30));
          else
            return Text("");
        },
      )
    );
  }

  String _formatText(){
    return "${weatherData.data["results"]["forecast"][0]["weekday"]}, ${_getDay()} ${_getMothExtent()}";
  }

  String _getDay(){
    return weatherData.data["results"]["forecast"][0]["date"].toString().split("/")[0].toString();
  }

  String _getMothExtent(){
    switch(weatherData.data["results"]["forecast"][0]["date"].toString().split("/")[1].toString()){
      case "01":
        return "Janeiro";
      case "02":
        return "Fevereiro";
      case "03":
        return "Março";
      case "04":
        return "Abril";
      case "05":
        return "Maio";
      case "06":
        return "Junho";
      case "07":
        return "Julho";
      case "08":
        return "Agosto";
      case "09":
        return "Setembro";
      case "10":
        return "Outubro";
      case "11":
        return "Novembro";
      case "12":
        return "Dezembro";
      default:
        return "";
    }
  }
}