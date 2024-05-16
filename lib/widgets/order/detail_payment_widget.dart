import 'package:flutter/material.dart';
import 'package:food_client/contants.dart';

class DetailPaymentWidget extends StatelessWidget {
  final double? total;

  const DetailPaymentWidget({super.key, this.total});

  final transportfee = 1600;



  @override
  Widget build(BuildContext context) {
    final formatTransport = formatCurrency(transportfee);
    final formatTotal = formatCurrency(total!.toInt());
    final totalPayment = total! + transportfee;
    final formattotalPayment = formatCurrency(totalPayment);
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white),
      child:  Padding(
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
            const SizedBox(height: 10.0,),
            Text("Tổng tiền hàng : $formatTotalđ"),
            Text("Phí vận chuyển : $formatTransportđ"),
            Text("Tổng thanh toán : $formattotalPaymentđ"),
          ],
        ),
      ),
    );
  }
}
