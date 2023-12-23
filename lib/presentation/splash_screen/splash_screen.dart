import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_with_api_and_provider/presentation/home_screen/home_screen.dart';
import 'package:weather_app_with_api_and_provider/utils/app_images.dart';
import 'package:weather_app_with_api_and_provider/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.appLogo,
              ),
              SizedBox(height: 20),
              CustomText(
                text: 'Musam App',
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              CustomText(
                text: 'Made by Ghammii',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey.shade500,
              ),
              SpinKitWave(
                color: Colors.black,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
