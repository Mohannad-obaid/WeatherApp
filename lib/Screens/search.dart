// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/weather_provider.dart';
import '../model/Weather_model.dart';
import '../service/weather_service.dart';
import 'package:geocoding/geocoding.dart';


class Search extends StatelessWidget {
  const Search({super.key});


  @override
  Widget build(BuildContext context) {

    Future<void> getCityName({required String name})async{

      WeatherService s = WeatherService();
      WeatherModel? weather = await s.getWeather(cityName: name);

      Provider.of<WeatherProvider>(context,listen: false).weatherData = weather;
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a City"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Image.network("https://cdn-icons-png.flaticon.com/512/3845/3845731.png",width: 200,height:200,),
              const SizedBox(height: 50,),

              TextField(
                onSubmitted: (data) async {
                  String cityName = data;

                  getCityName(name: cityName);

                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // hintText: 'Enter a city',
                  suffixIcon: const Icon(Icons.search),
                  label: const Text('Search a City'),
                ),
              ),

              const SizedBox(height: 30,),

              ElevatedButton.icon(onPressed: () async{

                  await Geolocator.checkPermission();
                  await Geolocator.requestPermission();

                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

                  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
                  String city = placemarks[0].locality!;

                   getCityName(name: city);

              }, icon: const Icon(Icons.location_on),
              label: const Text("Current location",style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
