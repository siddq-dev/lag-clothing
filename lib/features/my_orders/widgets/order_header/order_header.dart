import 'package:flutter/material.dart';


class OrdersHeader extends StatelessWidget {

  const OrdersHeader({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return const Text(

      "Your Recent Orders",

      style: TextStyle(

        color: Colors.white,

        fontSize:24,

        fontWeight:
        FontWeight.bold,

      ),

    );


  }

}