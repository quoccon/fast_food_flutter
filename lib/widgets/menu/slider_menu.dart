import 'package:flutter/material.dart';
import 'package:food_client/widgets/menu/infomation_widget.dart';

class SliderMenu extends StatefulWidget {
  const SliderMenu({super.key});

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xff17203a),
        child:  SafeArea(
          child: Column(
            children: [
             const InfomationWidget()
            ],
          ),
        ),
      ),
    );
  }
}
