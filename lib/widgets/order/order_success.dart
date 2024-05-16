import 'package:flutter/material.dart';

class OrderSuccessWidgt extends StatelessWidget {
  const OrderSuccessWidgt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Đặt hàng thành công"),
            SizedBox(height: 10,),
            Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child:  Center(child: Text("Tiếp tục mua sắm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
            )
          ],
        ),
      ),
    );
  }
}
