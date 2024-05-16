// import 'package:flutter/material.dart';
//
// import '../../contants.dart';
//
// class DetailProductOrder extends StatelessWidget {
//   const DetailProductOrder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 200,
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(20.0))),
//       child: Padding(
//         padding: const EdgeInsets.only(
//             top: 10,right: 20,left: 20,bottom: 10
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Chi tiết sản phẩm",style: TextStyle(fontSize: 20),),
//             const SizedBox(height: 10,),
//             Row(
//               children: [
//                 Image.network(imageUrl! + (widget.product?.imageproduct ?? ""),width: 100,height: 100,),
//                 const SizedBox(width: 5,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.product?.productname??"",style: const TextStyle(fontSize: 20),),
//                     Text("$formattedPriceđ",style: const TextStyle(fontSize: 15,color: Colors.green),),
//                   ],
//                 ),
//                 Expanded(child: Container()),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Số lượng :",
//                       style:
//                       TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                     ),
//                     Row(
//                       children: [
//                         GestureDetector(
//                             onTap: decrement,
//                             child: Image.asset(
//                               "assets/images/giam.png",
//                               color: Colors.black,width: 20,height: 20,
//                             )),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           widget.count.toString(),
//                           style: const TextStyle(fontSize: 20),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         GestureDetector(
//                           onTap: increment,
//                           child: Image.asset(
//                             "assets/images/tang.png",
//                             color: Colors.black,width: 20,height: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),;
//   }
// }
