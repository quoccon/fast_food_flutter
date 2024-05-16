import 'package:flutter/material.dart';
import 'package:food_client/models/user.dart';
import 'package:food_client/widgets/order/add_address.dart';

class DeliveryAddressWidget extends StatefulWidget {
  final User? user;
  final String? name, phone, address, district, city;

  const DeliveryAddressWidget(
      {super.key,
      this.user,
      this.name,
      this.phone,
      this.address,
      this.district,
      this.city});

  @override
  State<DeliveryAddressWidget> createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {
  bool isSelectdAddress = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/map-pin.png"),
                    const Text(
                      "Giao hàng",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "quoc - 0962580083",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text("43a, 43/58 Trần Bình, Hà Nội",
                        style: TextStyle(fontSize: 15)),
                  ],
                )
              ],
            ),
            Expanded(child: Container()),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAddress(user: widget.user)));
                },
                child: Image.asset("assets/images/chevron-right.png"))
          ],
        ),
      ),
    );
  }
}
