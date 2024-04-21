import 'package:flutter/material.dart';
import 'package:food_client/widgets/home/floating_widget.dart';
import 'package:food_client/widgets/home/search_widget.dart';
import 'package:food_client/widgets/home/slider_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title:  Text("Menu",style: GoogleFonts.abhayaLibre(fontSize: 28),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lets Eat Something",style: GoogleFonts.abel(fontSize: 30,fontWeight: FontWeight.w600),),
              Text("Delicious",style: GoogleFonts.abel(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.amber),),
              const SizedBox(height: 20.0,),
              const SearchWidget(),
              const SizedBox(height: 10.0,),
              const SliderWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingWidget(),
    );
  }
}

