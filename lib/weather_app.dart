import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_items.dart';
import 'package:weather_app/hourly_forecast_items.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secreats.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName = "Kathmandu";
  String countryCode = "np";
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final result = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,$countryCode&APPID=$openWeatherAPIkey',
        ),
      );

      final data = jsonDecode(result.body);

      if (data["cod"] != "200") {
        throw "An unexpected Error occured";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mausam",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "An unexpected error occured!",
                style: TextStyle(fontSize: 22),
              ),
            );
          }
          final data = snapshot.data!;
          final currentTemperature =
              "${((data['list'][0]['main']['temp']) - 273.15).floor()} °C";
          final currentSky = (data['list'][0]['weather'][0]['main']);
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];

          return Center(
            child: SizedBox(
              width: 432,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //main Card
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    currentTemperature,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Icon(
                                    currentSky == "Sunny"
                                        ? Icons.sunny
                                        : Icons.cloud,
                                    size: 64,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    currentSky,
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    //weather forcast Cards
                    const Text(
                      "Today's Forecast",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 25,
                        itemBuilder: (context, index) {
                          final hourlyForecast = data['list'][index + 1];
                          final hourlySky =
                              hourlyForecast['weather'][0]['main'];
                          final time = DateTime.parse(hourlyForecast['dt_txt']);

                          return HourlyForcastItem(
                            time: DateFormat.j().format(time).toString(),
                            icon: hourlySky == 'Rain'
                                ? Icons.thunderstorm
                                : hourlySky == 'Clouds'
                                    ? Icons.cloud
                                    : Icons.sunny,
                            temperature:
                                "${((data['list'][index + 1]['main']['temp']) - 273.15).floor()} °C",
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //additional information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoItems(
                          icon: Icons.water_drop,
                          info: "Humidity",
                          value: currentHumidity.toString(),
                        ),
                        AdditionalInfoItems(
                          icon: Icons.air,
                          info: "Wind Speed",
                          value: currentWindSpeed.toString(),
                        ),
                        AdditionalInfoItems(
                          icon: Icons.beach_access,
                          info: "Pressure",
                          value: currentPressure.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        child: DropdownButton<String>(
                          value: cityName,
                          icon: const Icon(Icons.keyboard_double_arrow_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              cityName = newValue;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: "Kathmandu",
                              child: Text(
                                "Kathmandu",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Tokha",
                              child: Text(
                                "Tokha",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Pokhara",
                              child: Text(
                                "Pokhara",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Biratnagar",
                              child: Text(
                                "Biratnagar",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Bhairahawa",
                              child: Text(
                                "Bhairahawa",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
