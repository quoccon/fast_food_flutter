import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/animation/loading_animation.dart';
import 'package:food_client/blocs/cart/cart_cubit.dart';
import 'package:food_client/blocs/home/product/product_cubit.dart';
import 'package:food_client/page/home_page.dart';
import 'package:food_client/widgets/home/detail_order.dart';
import 'package:lottie/lottie.dart';

import '../../contants.dart';
import '../../models/product.dart';
import '../../models/user.dart';

class DetailWidget extends StatelessWidget {
  final Product? product;
  final User? user;

  const DetailWidget({Key? key, required this.product, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: DetailProduct(product: product, user: user),
    );
  }
}

class DetailProduct extends StatefulWidget {
  final Product? product;
  final User? user;

  const DetailProduct({Key? key, required this.product, this.user})
      : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  // final String? imageUrl = "http://192.168.1.104:3000/";
  late int count;
  late double? total;
  bool isFaveroute = false;
  late CartCubit cartCubit;
  late ProductCubit productCubit;
  bool isWithList = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 1;
    isFaveroute = false;
    calculateTotal();
  }

  void calculateTotal() {
    total = (widget.product?.price ?? 0).toDouble() * count;
  }

  void increment() {
    setState(() {
      count++;
      calculateTotal();
    });
  }

  void decrement() {
    if (count > 1) {
      setState(() {
        count--;
        calculateTotal();
      });
    }
  }

  String formatCurrency(num amount) {
    final roundedAmount = amount.toStringAsFixed(2);
    final parts = roundedAmount.split('.');
    final currency = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    final decimals = parts[1] == '00' ? '' : '.${parts[1]}';
    return '$currency$decimals';
  }

  @override
  Widget build(BuildContext context) {
    cartCubit = context.read<CartCubit>();
    productCubit = context.read<ProductCubit>();
    final formattedAmount = formatCurrency(total!);
    final formattedPrice = formatCurrency(widget.product?.price ?? 0);
    final String productId = widget.product?.id ?? "";
    String userId = widget.user?.user?.id ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
        centerTitle: true,
      ),
      body: Stack(children: [
        Column(
          children: [
            Image.network(imageUrl! + (widget.product?.imageproduct ?? "")),
          ],
        ),
        Positioned(
          top: 200,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.product?.productname ?? "",
                          style: const TextStyle(fontSize: 25),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFaveroute = !isFaveroute;
                            });
                            productCubit.addWithList(userId, productId, () {
                              print('Đã thêm vào danh sách yêu thích');
                            });
                          },
                          child: isFaveroute
                              ? Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: Colors.red,
                                ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "$formattedPriceđ",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Mô tả",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(widget.product?.description ?? ""),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Số lượng :",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: decrement,
                            child: Image.asset(
                              "assets/images/giam.png",
                              color: Colors.black,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          count.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: increment,
                          child: Image.asset(
                            "assets/images/tang.png",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tổng :"),
                Text(
                  "$formattedAmountđ",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                )
              ],
            ),
            Expanded(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        cartCubit.addToCart(userId, productId, count, total!,
                            () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 50,
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.red,width: 2)
                        ),
                        child: const Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.shopping_cart,color: Colors.red,),
                              ),
                              Text(
                                "Giỏ hàng",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600,color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (BuildContext context){
                      return Center(
                        child: Lottie.asset('assets/images/loading_animaton.json', width: 200, height: 200),
                      );
                    });
                    
                    Future.delayed(Duration(seconds: 2),(){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOrder(product: widget.product, count: count, total: total,user:widget.user)));
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: const Center(
                      child: Text(
                        "Mua ngay",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600,color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
