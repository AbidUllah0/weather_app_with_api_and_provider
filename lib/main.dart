import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_with_api_and_provider/presentation/home_screen/home_screen.dart';
import 'package:weather_app_with_api_and_provider/presentation/location_screen/location_screen.dart';
import 'package:weather_app_with_api_and_provider/presentation/splash_screen/splash_screen.dart';
import 'package:weather_app_with_api_and_provider/provider/weather_api_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherApiProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
