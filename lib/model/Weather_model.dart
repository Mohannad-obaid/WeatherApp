class WeatherModel {
  String name;
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;
  List<dynamic> hour;
  String imageState;

  WeatherModel(
      {required this.name,
      required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName,
      required this.hour,
      required this.imageState
      });

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    var hourData = data['forecast']['forecastday'][0]['hour'];
    return WeatherModel(
        name: data['location']['name'],
        date: data['location']['localtime'],
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStateName: jsonData['condition']['text'],
        imageState: jsonData['condition']['icon'],
        hour: hourData);
  }

  @override
  String toString() {
    return 'WeatherModel{name: $name, date: $date, temp: $temp, maxTemp: $maxTemp, minTemp: $minTemp, weatherStateName: $weatherStateName,hour : $hour}';
  }
}
