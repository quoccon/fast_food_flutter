import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/blocs/cart/cart_cubit.dart';
import 'package:food_client/contants.dart';
import 'package:food_client/widgets/order/order_with_cart.dart';
import 'package:lottie/lottie.dart';

import '../../models/cart.dart';
import '../../models/user.dart';

class CartPage extends StatelessWidget {
  final User? user;

  const CartPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: CartBody(user: user),
    );
  }
}

class CartBody extends StatefulWidget {
  final User? user;

  const CartBody({super.key, this.user});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  late CartCubit cartCubit;
  late int count;
  bool isPayment = false;
  Set<int> selectedItem = {};
  bool isCheck = false;
  double totalPayment = 0;

  @override
  void initState() {
    super.initState();
  }

  double calculateTotalPayment(List<Cart> selectedItems){
    double total = 0;
    for(var item in selectedItems){
      total += (item.price! * item.quantity!);
    }
    return total;
  }

  void showDialogPayment(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Lottie.asset('assets/images/loading_animaton.json', width: 200, height: 200),
        );
      },
    );
  }

  void loadingPayment(BuildContext context) {
    setState(() {
      isPayment = true;
    });

  }

  // 1. Hàm này sẽ chuyển đổi danh sách các chỉ mục đã chọn thành danh sách các đối tượng Cart tương ứng
  List<Cart> _getSelectedItems(BuildContext context) {
    final state = context.read<CartCubit>().state;
    if (state is CartSuccess) {
      final listCart = state.cart;
      return selectedItem.map((index) => listCart[index]).toList(); // Thêm .toList() vào đây
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = widget.user?.user?.id ?? "";
    context.read<CartCubit>().getCart(userId);
    print('userId ===: $userId');
    final formatTotalPayment = formatCurrency(totalPayment);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            return const Center(
              child: Text("Chưa có sản phẩm nào trong giỏ hàng"),
            );
          } else if (state is CartSuccess) {
            final listCart = state.cart;
            final int count = state.cart.length;
            print('cout == $count');
            if(count == 0){
              return const Center(
                child: Text("Bạn chưa có sản phẩm nào trong giỏ hàng"),
              );
            }
            return ListView.builder(
              itemCount: listCart.length,
              itemBuilder: (context, index) {
                final cart = listCart[index];
                double? total = (cart.price!.toDouble() * cart.quantity!.toInt())!;
                print('total ==== $total');
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: selectedItem.contains(index),
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue != null && newValue) {
                                  selectedItem.add(index);
                                  print('select === $selectedItem');
                                } else {
                                  selectedItem.remove(index);
                                }
                                totalPayment = calculateTotalPayment(_getSelectedItems(context));
                              });
                            },
                          ),
                          Image.network(
                            imageUrl! + (cart?.imageproduct ?? ""),
                            width: 100,
                            height: 80,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cart?.productname ?? "",
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                cart?.price.toString() ?? "",
                                style: const TextStyle(fontSize: 15, color: Colors.green),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (cart != null && cart.quantity! > 0) {
                                          setState(() {
                                            cart.quantity;
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/images/giam.png",
                                        color: Colors.black,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    cart?.quantity.toString() ?? "",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Image.asset(
                                      "assets/images/tang.png",
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Color(0xffDDDDDD)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Row(
                children: [
                  const Text("Tổng : ",style: TextStyle(fontWeight: FontWeight.w500),),
                  Text("$formatTotalPaymentđ",style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w600),)
                ],
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  showDialogPayment(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      isPayment = false;
                    });
                    Navigator.of(context).pop();
                    // 3. Truyền danh sách các đối tượng Cart đã chọn sang trang OrderWithCart
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderWithCart(listCart: _getSelectedItems(context)),
                      ),
                    );
                  });
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.red),
                  child: const Center(
                      child: Text(
                        "Thanh toán",
                        style: TextStyle(
                            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
