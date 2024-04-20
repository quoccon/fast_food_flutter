import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlashScreen extends StatelessWidget {
  const PlashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              child: Lottie.asset("assets/images/animation2.json", width: 500, height: 300),
            ),
          ),
       
          Spacer(),
        ],
      ),
    );
  }
}
