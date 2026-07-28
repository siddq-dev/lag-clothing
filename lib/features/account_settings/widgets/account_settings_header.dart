import 'package:flutter/material.dart';


class AccountSettingsHeader extends StatelessWidget {


  const AccountSettingsHeader({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),


      decoration: BoxDecoration(

        color: Colors.grey.shade900,

        borderRadius:
        BorderRadius.circular(16),

      ),


      child: const Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [


          Text(

            "Account Privacy & Security",

            style: TextStyle(

              color: Colors.white,

              fontSize:22,

              fontWeight:
              FontWeight.bold,

            ),

          ),



          SizedBox(height:8),



          Text(

            "Manage your account preferences",

            style: TextStyle(

              color: Colors.grey,

            ),

          ),


        ],

      ),

    );


  }


}