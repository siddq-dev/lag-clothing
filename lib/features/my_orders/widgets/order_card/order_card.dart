import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';
import '../order_status_chip.dart';



class OrderCard extends StatelessWidget {


  final OrderModel order;

  final VoidCallback onTap;



  const OrderCard({

    super.key,

    required this.order,

    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return Card(

      color:
      Colors.grey.shade900,


      margin:
      const EdgeInsets.only(
        bottom:15,
      ),



      child: InkWell(

        onTap:onTap,


        child: Padding(

          padding:
          const EdgeInsets.all(16),


          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [


              Text(

                "Order #${order.orderNumber}",

                style:
                const TextStyle(

                  color: Colors.white,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),



              const SizedBox(
                height:10,
              ),



              Text(

                "Total: ₹${order.total}",

                style:
                const TextStyle(

                  color: Colors.white,

                ),

              ),



              const SizedBox(
                height:10,
              ),



              OrderStatusChip(

                status:
                order.orderStatus.name,

              ),

            ],

          ),

        ),

      ),

    );


  }


}