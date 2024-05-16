import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/blocs/home/product/category/category_cubit.dart';
import 'package:food_client/widgets/home/list_product_by_cat.dart';

import '../../contants.dart';
import '../../models/user.dart';

class CategoryWidget extends StatelessWidget {
  final User? user;
  const CategoryWidget({Key? key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child:  Category(user: user,),
    );
  }
}

class Category extends StatefulWidget {
  final User? user;
  const Category({Key? key, this.user});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late CategoryCubit categoryCubit;
  // String? imageUrl = "http://192.168.1.104:3000/";

  Color _randomColor() {
    // Tạo một số ngẫu nhiên từ 0 đến 255 cho mỗi thành phần màu
    final random = Random();
    final r = random.nextInt(163);
    final g = random.nextInt(143);
    final b = random.nextInt(236);
    // Trả về một màu ngẫu nhiên
    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {

    context.read<CategoryCubit>().getCat();
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CatSuccess) {
          final cat = state.category;
          return SizedBox(
            height: 110,
            child: ListView.builder(
              itemCount: cat.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final category = cat[index];
                String catname = category?.category ?? "";
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  ListProductByCat(cat:catname,user:widget.user)));
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: _randomColor(),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                              border: Border.all(
                                  color: Colors.black, width: 1)),
                          child: Center(
                            child: Image.network(
                              imageUrl! + (category?.imageCat ?? ""), width: 40,
                              height: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(category?.category ?? ""),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          // Add a default return statement
          // You can return a loading indicator or any default widget here
          return const CircularProgressIndicator(); // Example: Return a loading indicator
        }
      },
    );
  }
}
