import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Screens/search.dart';
import 'package:weatherapp/model/Weather_model.dart';
import 'package:weatherapp/provider/weather_provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;
  DateFormat formatter = DateFormat("H ");


  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Search();
                }));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: weatherData == null
          ? const Center(
              child: Text("There is no weather.. start \n searching now"),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff5FC9F6), Color(0xff59509D)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  //stops: [0.4, 0.7],
                  // tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Text(
                    weatherData?.name ?? ' ',
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    weatherData?.weatherStateName ?? ' ',
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.amber,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Image.network(
                    'https:${weatherData!.imageState}',
                    // color: Colors.white,
                  ),
                  Text(
                    '${weatherData!.temp.toInt()}',
                    style: const TextStyle(fontSize: 60, color: Colors.white),
                  ),
                  Text(
                    '${weatherData!.minTemp.toInt()}° / ${weatherData!.maxTemp.toInt()}°',
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: double.maxFinite,
                      height: 96,
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: weatherData!.hour.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                formatter.format(DateTime.parse(
                                    '${weatherData!.hour[index]['time']}')),
                                style: const TextStyle(color: Color(0xff5A59A3)),
                              ),
                              Image.network(
                                'https:${weatherData!.hour[index]['condition']['icon']}',
                              )
                            ],
                          );
                        },
                      )),
                ],
              ),
            ),
    );
  }
}


