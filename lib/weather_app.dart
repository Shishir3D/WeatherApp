import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_items.dart';
import 'package:weather_app/hourly_forecast_items.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("refreshed");
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
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
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "30° C",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Rain",
                            style: TextStyle(
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
              "Weather Forecast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcastItem(
                    time: "00:00",
                    icon: Icons.cloud,
                    temperature: "22° C",
                  ),
                  HourlyForcastItem(
                    time: "3:00",
                    icon: Icons.sunny,
                    temperature: "26° C",
                  ),
                  HourlyForcastItem(
                    time: "06:00",
                    icon: Icons.cloud,
                    temperature: "23° C",
                  ),
                  HourlyForcastItem(
                    time: "09:00",
                    icon: Icons.thunderstorm,
                    temperature: "20° C",
                  ),
                  HourlyForcastItem(
                    time: "12:00",
                    icon: Icons.ramen_dining,
                    temperature: "45° C",
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Additional Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 20,
            ),

            //additional information
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItems(
                  icon: Icons.water_drop,
                  info: "Humidity",
                  value: "80",
                ),
                AdditionalInfoItems(
                  icon: Icons.air,
                  info: "Wind Speed",
                  value: "7.5",
                ),
                AdditionalInfoItems(
                  icon: Icons.beach_access,
                  info: "Pressure",
                  value: "1000",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
