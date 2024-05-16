import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> imagePath = [
      "assets/images/BaconandCheeseHeaven.jpg",
      "assets/images/BaconWrappedFiletMignon.jpg",
      "assets/images/BBQChickenDelight.jpg",
    ];
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: imagePath.length,
          options: CarouselOptions(
            height: 300,
            // autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 2),
          ),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(imagePath[itemIndex]),
                  fit: BoxFit.cover)
                ),
              ),
            );
          }),
    );
  }
}
