import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_client/blocs/cart/cart_cubit.dart';
import '../../models/cart.dart';

class OrderWithCart extends StatelessWidget {
  final List<Cart> listCart;

  const OrderWithCart({Key? key, required this.listCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: OrderCart(listCart: listCart),
    );
  }
}

class OrderCart extends StatefulWidget {
  final List<Cart> listCart;

  const OrderCart({Key? key, required this.listCart}) : super(key: key);

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: widget.listCart.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white
              ),
            );
          },
        )
    );
  }
}
