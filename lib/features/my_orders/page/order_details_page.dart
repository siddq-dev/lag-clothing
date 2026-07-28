import 'package:flutter/material.dart';

import '../../../models/order_model.dart';
import '../widgets/order_summary.dart';
import '../widgets/order_status_chip.dart';
import '../widgets/cancel_order_button.dart';
import '../widgets/download_invoice_button.dart';
import '../widgets/buy_again_button.dart';
import 'order_tracking_page.dart';



class OrderDetailsPage extends StatelessWidget {


  final OrderModel order;



  const OrderDetailsPage({

    super.key,

    required this.order,

  });



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
      Colors.black,


      appBar: AppBar(

        title:
        const Text(
          "Order Details",
        ),

        backgroundColor:
        Colors.black,

        foregroundColor:
        Colors.white,

      ),



      body: Padding(

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

                color:Colors.white,

                fontSize:22,

              ),

            ),



            const SizedBox(
              height:15,
            ),



            OrderStatusChip(

              status:
              order.orderStatus.name,

            ),



            const SizedBox(
              height:20,
            ),



            OrderSummary(
              order: order,
            ),




            const Spacer(),

ElevatedButton(

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            OrderTrackingPage(
              order: order,
            ),

      ),

    );

  },


  child: const Text(
    "Track Order",
  ),

),

            DownloadInvoiceButton(),



            CancelOrderButton(
              orderId: order.id,
            ),



            BuyAgainButton(
              order: order,
            ),


          ],

        ),

      ),

    );

  }

}