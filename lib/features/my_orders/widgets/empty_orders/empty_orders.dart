import 'package:flutter/material.dart';


class EmptyOrders extends StatelessWidget {


  const EmptyOrders({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return const Center(

      child:

      Text(

        "No Orders Found",

        style:

        TextStyle(

          color:Colors.white,

          fontSize:20,

        ),

      ),

    );


  }

}