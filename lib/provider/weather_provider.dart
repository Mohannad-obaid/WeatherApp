import 'package:flutter/foundation.dart';
import 'package:weatherapp/model/Weather_model.dart';


class WeatherProvider extends ChangeNotifier{
  WeatherModel? _weatherData;


  set weatherData(WeatherModel? weather){
    _weatherData = weather;
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;

  }
