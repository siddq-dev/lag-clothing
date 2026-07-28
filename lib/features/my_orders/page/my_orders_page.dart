import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';
import '../widgets/order_header/order_header.dart';
import '../widgets/order_card/order_card.dart';
import '../widgets/empty_orders/empty_orders.dart';
import 'order_details_page.dart';


class MyOrdersPage extends StatefulWidget {

  const MyOrdersPage({
    super.key,
  });


  @override
  State<MyOrdersPage> createState() =>
      _MyOrdersPageState();

}



class _MyOrdersPageState
    extends State<MyOrdersPage> {


  @override
  void initState() {

    super.initState();


    Future.microtask(() {

      context
          .read<OrderProvider>()
          .fetchOrders();

    });

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.black,


      appBar: AppBar(

        title:
        const Text(
          "My Orders",
        ),

        backgroundColor:
        Colors.black,

        foregroundColor:
        Colors.white,

      ),



      body:

      Consumer<OrderProvider>(


        builder: (
          context,
          provider,
          child,
        ){


          if(provider.isLoading){

            return const Center(

              child:
              CircularProgressIndicator(),

            );

          }



          if(provider.orders.isEmpty){

            return const EmptyOrders();

          }



          return ListView(

            padding:
            const EdgeInsets.all(16),


            children: [

              const OrdersHeader(),



              const SizedBox(
                height:20,
              ),



              ...provider.orders.map(

                (order)=>OrderCard(

                  order: order,

                  onTap: (){


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:(_)=>
                        OrderDetailsPage(

                          order: order,

                        ),

                      ),

                    );


                  },

                ),

              ),

            ],

          );


        },

      ),

    );

  }

}