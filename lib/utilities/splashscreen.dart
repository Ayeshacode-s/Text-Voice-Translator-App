import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../routes/app_pages.dart';
import 'TextStyle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () async {
      Get.offNamedUntil(
          Routes.login, ModalRoute.withName(Routes.login));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                AppColors.btnG1,
                AppColors.btnG2
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Translator-rafiki.png',
                width: 400,
                height: 400,
              ),
              SizedBox(height: 16),
              Text(
                "VOICE AND TEXT TRANSLATOR",
                style: montserratBold(
                  color: AppColors.textColor,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}