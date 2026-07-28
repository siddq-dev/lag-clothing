import 'package:flutter/material.dart';

import '../../../models/order_model.dart';
import '../widgets/tracking_step.dart';



class OrderTrackingPage extends StatelessWidget {


  final OrderModel order;



  const OrderTrackingPage({

    super.key,

    required this.order,

  });



  int getStatusIndex(){


    switch(order.orderStatus){


      case OrderStatus.placed:
        return 0;


      case OrderStatus.confirmed:
        return 1;


      case OrderStatus.packed:
        return 2;


      case OrderStatus.shipped:
        return 3;


      case OrderStatus.outForDelivery:
        return 4;


      case OrderStatus.delivered:
        return 5;


      case OrderStatus.cancelled:
      case OrderStatus.returned:
        return -1;

    }

  }



  @override
  Widget build(BuildContext context) {


    final current =
        getStatusIndex();



    final steps = [

      {
        "title":"Order Placed",
        "subtitle":"Your order has been received"
      },


      {
        "title":"Confirmed",
        "subtitle":"Seller confirmed your order"
      },


      {
        "title":"Packed",
        "subtitle":"Your package is ready"
      },


      {
        "title":"Shipped",
        "subtitle":"Package handed to delivery partner"
      },


      {
        "title":"Out For Delivery",
        "subtitle":"Delivery partner is nearby"
      },


      {
        "title":"Delivered",
        "subtitle":"Order successfully delivered"
      },

    ];



    return Scaffold(

      backgroundColor:
      Colors.black,


      appBar: AppBar(

        backgroundColor:
        Colors.black,

        foregroundColor:
        Colors.white,


        title:

        const Text(
          "Track Order",
        ),

      ),



      body: Padding(

        padding:
        const EdgeInsets.all(20),



        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [


            Text(

              "Order #${order.orderNumber}",

              style:
              const TextStyle(

                color:
                Colors.white,

                fontSize:22,

                fontWeight:
                FontWeight.bold,

              ),

            ),



            const SizedBox(
              height:30,
            ),



            if(order.trackingId.isNotEmpty)

              Text(

                "Tracking ID: ${order.trackingId}",

                style:
                const TextStyle(

                  color:
                  Colors.grey,

                ),

              ),



            const SizedBox(
              height:30,
            ),



            Expanded(

              child: ListView.builder(

                itemCount:
                steps.length,


                itemBuilder:
                (context,index){


                  return TrackingStep(

                    title:
                    steps[index]["title"]!,


                    subtitle:
                    steps[index]["subtitle"]!,


                    completed:
                    index < current,


                    active:
                    index == current,

                  );


                },

              ),

            )

          ],

        ),

      ),

    );

  }

}