import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/blocs/order/order_cubit.dart';
import 'package:food_client/contants.dart';
import 'package:food_client/widgets/order/delivery_address_widget.dart';
import 'package:food_client/widgets/order/detail_payment_widget.dart';
import 'package:food_client/widgets/order/order_success.dart';
import 'package:food_client/widgets/order/payment_method_widget.dart';

import '../../models/product.dart';
import '../../models/user.dart';

class DetailOrder extends StatelessWidget {
  final Product? product;
  final User? user;
  final int count;
  final double? total;

  const DetailOrder({super.key,
    required this.product,
    required this.count,
    required this.total,
    this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: DetailOrderWidget(
        user: user,
        product: product,
        count: count,
        total: total,
      ),
    );
  }
}

class DetailOrderWidget extends StatefulWidget {
  final Product? product;
  final User? user;
  late int count;
  late double? total;

  DetailOrderWidget({super.key,
    required this.product,
    required this.count,
    required this.total,
    this.user});

  @override
  State<DetailOrderWidget> createState() => _DetailOrderWidgetState();
}

class _DetailOrderWidgetState extends State<DetailOrderWidget> {
  final transportfee = 16000;

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

  void increment() {
    setState(() {
      widget.count++;
      calculateTotal();
    });
  }

  void decrement() {
    if (widget.count > 1) {
      setState(() {
        widget.count--;
        calculateTotal();
      });
    }
  }

  void calculateTotal() {
    widget.total = (widget.product?.price ?? 0).toDouble() * widget.count;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrice = formatCurrency(widget.product?.price ?? 0);
    final formatTransport = formatCurrency(transportfee);
    final formatTotal = formatCurrency(widget.total!);
    final totalPayment = widget.total! + transportfee;
    final formattotalPayment = formatCurrency(totalPayment);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết đơn hàng"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Chi tiết sản phẩm",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.network(
                                imageUrl! +
                                    (widget.product?.imageproduct ?? ""),
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.product?.productname ?? "",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "x${widget.count.toString()}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "$formattedPriceđ",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DeliveryAddressWidget(user: widget.user),
                  const SizedBox(
                    height: 10.0,
                  ),

                  ////DETAIL PAYMENT
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/receipt-text.png"),
                              const Text(
                                "Chi tiết thanh toán",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text("Tổng tiền hàng : $formatTotalđ"),
                          Text("Phí vận chuyển : $formatTransportđ"),
                          Text("Tổng thanh toán : $formattotalPaymentđ"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const PaymentMethodWidget()
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Row(
              children: [
                const Text("Thanh toán :"),
                Text("$formattotalPaymentđ", style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),),
              ],
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: (){
                Future.delayed(Duration(seconds: 2),(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrderSuccessWidgt()));
                });
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.red),
                child: const Center(
                  child: Text(
                    "Đặt hàng",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
