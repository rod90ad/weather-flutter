import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'weather_data.g.dart';

class WeatherData = _WeatherDataBase with _$WeatherData;

abstract class _WeatherDataBase with Store {

  @observable
  Map<String,dynamic> data;

  int _woeid = 455827;

  _WeatherDataBase(){
    getData();
  }

  void getData({int woeid}) async {
    print("getting data from api");
    if(woeid!=null) _woeid = woeid;
    var response = await http.get("https://api.hgbrasil.com/weather?woeid=$_woeid");
    if(response.statusCode==200)
      data = json.decode(response.body);
  }
}