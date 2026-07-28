import 'package:flutter/material.dart';

import '../../../models/order_model.dart';



class OrderSummary extends StatelessWidget {


  final OrderModel order;


  const OrderSummary({

    super.key,

    required this.order,

  });



  @override
  Widget build(BuildContext context) {


    return Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,


      children: [


        Text(

          "Items: ${order.items.length}",

          style:
          const TextStyle(
            color:Colors.white,
          ),

        ),



        Text(

          "Subtotal: ₹${order.subtotal}",

          style:
          const TextStyle(
            color:Colors.white,
          ),

        ),



        Text(

          "Total: ₹${order.total}",

          style:
          const TextStyle(
            color:Colors.white,
          ),

        ),

      ],

    );


  }

}