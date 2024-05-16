import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({Key? key}) : super(key: key);

  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  String? selectedPaymentMethod = "Thanh toán bằng tiền mặt";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Phương thức thanh toán",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(selectedPaymentMethod!),
                const Expanded(child: SizedBox()),
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(context: context, builder: (BuildContext context){
                        return Container(
                          height: 300,

                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child:  Column(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.payment),
                                title: const Text("Thanh toán bằng tiền mặt"),
                                onTap: (){
                                  setState(() {
                                    selectedPaymentMethod = "Thanh toán bằng tiền mặt";
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.payment),
                                title: const Text("Thanh toán bằng ví Momo"),
                                onTap: (){
                                  setState(() {
                                    selectedPaymentMethod = "Thanh toán bằng ví Momo";
                                  });
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        );
                      });
                    },
                    child: Image.asset("assets/images/chevron-right.png"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
