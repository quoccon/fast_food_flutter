import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/blocs/home/product/product_cubit.dart';
import 'package:food_client/widgets/home/cart_page.dart';
import 'package:food_client/widgets/home/detail_widget.dart';
import 'package:food_client/widgets/home/floating_widget.dart';

import '../../contants.dart';
import '../../models/user.dart';

class ListProductByCat extends StatelessWidget {
  final String cat;
  final User? user;

  const ListProductByCat({super.key, required this.cat, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: ProductByCat(
        cat: cat,
        user: user,
      ),
    );
  }
}

class ProductByCat extends StatefulWidget {
  final String cat;
  final User? user;

  const ProductByCat({Key? key, required this.cat, this.user})
      : super(key: key);

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late ProductCubit productCubit;
  late final controller = AnimationController(vsync: this);
  late final cartController = AnimationController(vsync: this);
  late final manager = AddToCartAnimation(controller);
  String selectedItem = "";

  @override
  void dispose() {
    controller.dispose();
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().getProductByCategory(widget.cat);
    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(user: widget.user)));
          },
          child: FloatingWidget(
            key: manager.cartKey,
          )
              .animate(
                  controller: cartController,
                  autoPlay: false,
                  onComplete: (controller) {
                    controller.reset();
                  })
              .moveY(begin: 0, end: -20, duration: 500.ms)
              .shake()),
      appBar: AppBar(
        title: Text(widget.cat),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            final productList = state.product;
            return Stack(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(productList.length, (index) {
                    final list = productList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailWidget(
                                      product: list, user: widget.user)));
                        },
                        child: Container(
                          key: manager.productKeys[index],
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0)),
                                      child: Image.network(

                                        imageUrl! + (list?.imageproduct ?? ""),
                                        width: 200,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Icon(Icons.favorite_border))
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        list?.productname ?? "",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedItem =
                                                list?.imageproduct.toString() ??
                                                    "";
                                          });
                                          manager.runAnimation(index);
                                        },
                                        child: Container(
                                            width: 30,
                                            height: 30,
                                            color: Colors.amber,
                                            child: const Icon(
                                                Icons.shopping_cart)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        list?.price.toString() ?? "",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                ListenableBuilder(
                  listenable: manager.productSize,
                  builder: (context, _) {
                    return SizedBox(
                            width: manager.productSize.value.width,
                            height: manager.productSize.value.height,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              child: Image.network(
                                imageUrl! + (selectedItem),
                                width: 200,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                                .animate(
                                  autoPlay: false,
                                  controller: controller,
                                )
                                .scale(
                                    duration: 2.seconds,
                                    begin: Offset(1, 1),
                                    end: Offset.zero,
                                    alignment: Alignment.bottomRight,
                                    delay: 500.ms))
                        .animate(
                            autoPlay: false,
                            controller: manager.controller,
                            onComplete: (controller) {
                              controller.reset();
                              manager.reset();
                              cartController.forward();
                            })
                        .followPath(
                            duration: 2.seconds,
                            path: manager.path,
                            curve: Curves.easeInOutCubic);
                  },
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class AddToCartAnimation {
  final AnimationController controller;

  AddToCartAnimation(this.controller);

  final productKeys = List.generate(20, (index) => GlobalKey());
  final cartKey = GlobalKey();
  var productSize = ValueNotifier(const Size(0, 0));
  var productPosition = Offset.zero;
  var path = Path();

  void dispose() {
    productSize.dispose();
  }

  void reset() {
    productSize.value = Size.zero;
    productPosition = Offset.zero;
    path = Path();
  }

  void runAnimation(int index) {
    final productContext = productKeys[index].currentContext!;
    final cartPosition =
        (cartKey.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);
    final cartBottomRight =
        cartKey.currentContext!.size!.bottomRight(cartPosition);
    productPosition = (productContext.findRenderObject() as RenderBox)
        .localToGlobal(Offset.zero);
    productSize.value = productContext.size!;
    //
    path = Path()
      ..moveTo(productPosition.dx, productPosition.dy)
      ..relativeLineTo(-20, -20)
      ..lineTo(cartBottomRight.dx - productSize.value.width,
          cartBottomRight.dy - productSize.value.height);
    controller.forward();
  }
}
