import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_with_api_and_provider/models/WeatherModel.dart';
import 'package:weather_app_with_api_and_provider/provider/weather_api_provider.dart';
import 'package:weather_app_with_api_and_provider/widgets/custom_text.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var cityName = ['Mumbai', 'Delhi', 'Chennai', 'Dhar', 'Indore', 'London'];
    final randon = Random();
    var city = cityName[randon.nextInt(cityName.length)];

    final weatherProvider = Provider.of<WeatherApiProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
          future: weatherProvider.getWeatherData(countryName: city),
          builder: (context, snapshot) {
            String temperatureString = snapshot.data![0].main!.temp.toString();
            double temperature = double.parse(temperatureString);
            double subtractedValue = temperature - 273.15;

            String icon = snapshot.data![0].weather![0].icon.toString();
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitFadingCircle(
                  size: 60,
                  color: Colors.black,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitRotatingCircle(
                  size: 50,
                  color: Colors.black,
                ),
              );
            } else {
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.shade800,
                        Colors.blue.shade300,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search ${city}',
                            prefixIcon: Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.black12.withOpacity(0.1),
                              ),
                              child: Icon(Icons.search),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                                'https://openweathermap.org/img/wn/$icon@2x.png'),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                CustomText(
                                  text: snapshot
                                      .data![0].weather![0].description
                                      .toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: snapshot.data![0].name.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: height * 0.35,
                        padding: EdgeInsets.all(10),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.thermostat_outlined,
                              size: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: subtractedValue
                                      .toString()
                                      .substring(0, 5),
                                  fontSize: 80,
                                ),
                                CustomText(
                                  text: 'C',
                                  fontSize: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: height * 0.2,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(WeatherIcons.day_cloudy_windy),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  CustomText(
                                    text: snapshot.data![0].wind!.speed
                                        .toString(),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(text: 'km/hr'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: height * 0.2,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(WeatherIcons.humidity),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  CustomText(
                                    text: snapshot.data![0].main!.humidity
                                        .toString(),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(text: 'percent'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(text: 'Made by ...'),
                            CustomText(
                                text:
                                    'Data Provided by openweathermap.org ...'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      // body: Consumer<WeatherApiProvider>(
      //   builder: (context, provider, child) {
      //     return InkWell(
      //       onTap: () {
      //         focusNode.unfocus();
      //       },
      //       child: SafeArea(
      //         child: SingleChildScrollView(
      //           child: Container(
      //             padding: EdgeInsets.all(20),
      //             decoration: BoxDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment.topCenter,
      //                 end: Alignment.bottomCenter,
      //                 colors: [
      //                   Colors.blue.shade800,
      //                   Colors.blue.shade300,
      //                 ],
      //               ),
      //             ),
      //             child: Column(
      //               children: [
      //                 Container(
      //                   height: MediaQuery.of(context).size.height * 0.06,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(24),
      //                     color: Colors.white,
      //                   ),
      //                   child: TextFormField(
      //                     focusNode: focusNode,
      //                     controller: _searchController,
      //                     decoration: InputDecoration(
      //                       hintText: 'Search ${city}',
      //                       prefixIcon: Container(
      //                         margin: EdgeInsets.all(5),
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(24),
      //                           color: Colors.black12.withOpacity(0.1),
      //                         ),
      //                         child: Icon(Icons.search),
      //                       ),
      //                       border: InputBorder.none,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 10),
      //                 Container(
      //                   padding: EdgeInsets.all(25),
      //                   width: width,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(14),
      //                     color: Colors.white.withOpacity(0.5),
      //                   ),
      //                   child: Row(
      //                     children: [
      //                       // Image.network('src'),
      //                       Column(
      //                         children: [
      //                           CustomText(
      //                             text: 'Scattered Cloud',
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                           CustomText(
      //                             text: 'In Pak',
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 10),
      //                 Container(
      //                   height: height * 0.35,
      //                   padding: EdgeInsets.all(10),
      //                   width: width,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(14),
      //                     color: Colors.white.withOpacity(0.5),
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Icon(
      //                         Icons.thermostat_outlined,
      //                         size: 40,
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           CustomText(
      //                             text: provider.weatherList[0].coord!.lat
      //                                 .toString(),
      //                             fontSize: 80,
      //                           ),
      //                           CustomText(
      //                             text: 'C',
      //                             fontSize: 30,
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 10),
      //                 Row(
      //                   children: [
      //                     Expanded(
      //                       child: Container(
      //                         height: height * 0.2,
      //                         padding: EdgeInsets.all(10),
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(14),
      //                           color: Colors.white.withOpacity(0.5),
      //                         ),
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               children: [
      //                                 Icon(WeatherIcons.day_cloudy_windy),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                             CustomText(
      //                               text: '',
      //                               fontSize: 40,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                             CustomText(text: 'km/hr'),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(width: 10),
      //                     Expanded(
      //                       child: Container(
      //                         height: height * 0.2,
      //                         padding: EdgeInsets.all(10),
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(14),
      //                           color: Colors.white.withOpacity(0.5),
      //                         ),
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               children: [
      //                                 Icon(WeatherIcons.humidity),
      //                               ],
      //                             ),
      //                             SizedBox(height: 20),
      //                             CustomText(
      //                               text: '29.9',
      //                               fontSize: 40,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                             CustomText(text: 'percent'),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 10),
      //                 Container(
      //                   padding: EdgeInsets.all(10),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     children: [
      //                       CustomText(text: 'Made by ...'),
      //                       CustomText(
      //                           text:
      //                               'Data Provided by openweathermap.org ...'),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
