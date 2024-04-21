import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_client/page/auth/login_page.dart';
import 'package:lottie/lottie.dart';

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
    Timer(const Duration(seconds: 7), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xffFFC529),),
      backgroundColor: const Color(0xffFFC529),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Lottie.asset("assets/images/animation1.json", width: 300, height: 300),
            ),
          ),
          Expanded(
            child: Center(
              child: Lottie.asset("assets/images/animation2.json"),
            ),
          ),

          Spacer(),
        ],
      ),
    );
  }
}


