import 'package:flutter/material.dart';
import 'package:food_client/widgets/home/category_widget.dart';
import 'package:food_client/widgets/home/floating_widget.dart';
import 'package:food_client/widgets/home/product_list.dart';
import 'package:food_client/widgets/home/search_widget.dart';
import 'package:food_client/widgets/home/slider_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user.dart';

class HomePage extends StatelessWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    String? username = user?.user?.id ?? "";
    print('username == $username');
    return HomeScreen(
      user: user,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text(
          "Menu",
          style: GoogleFonts.abhayaLibre(fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            "assets/images/circle-user.png",
            width: 50,
            height: 50,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lets Eat Something",
                style:
                    GoogleFonts.abel(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text(
                "Delicious",
                style: GoogleFonts.abel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SearchWidget(),
              const SizedBox(
                height: 10.0,
              ),
              const SliderWidget(),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Thể Loại",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CategoryWidget(
                user: widget.user,
              ),
              const SizedBox(height: 10.0),
              Text(
                "Sản phẩm",
                style: GoogleFonts.abhayaLibre(
                    fontSize: 25, fontWeight: FontWeight.w700),
              ),
              // const ProductList(),
            ],
          ),
        ),
      ),
      floatingActionButton:
          GestureDetector(onTap: () {}, child: FloatingWidget()),
    );
  }
}
