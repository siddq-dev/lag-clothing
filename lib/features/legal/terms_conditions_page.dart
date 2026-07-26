import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {

  const TermsConditionsPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,


      appBar: AppBar(

        backgroundColor: Colors.black,

        elevation: 0,


        title: const Text(
          "Terms & Conditions",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),


        iconTheme:
            const IconThemeData(
              color: Colors.white,
            ),
      ),



      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(24),


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            const Text(

              "Terms & Conditions",

              style: TextStyle(

                color: Colors.white,

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,

              ),
            ),



            const SizedBox(height: 20),



            section(
              "Acceptance of Terms",

              "By accessing and using LAG Clothing, "
              "you agree to follow these terms and conditions.",
            ),



            section(
              "Products and Pricing",

              "All products displayed on our website "
              "are subject to availability. Prices may "
              "change without prior notice.",
            ),



            section(
              "Orders",

              "Once an order is placed, customers will "
              "receive confirmation. Orders may be "
              "cancelled according to our cancellation policy.",
            ),



            section(
              "Shipping",

              "Delivery times may vary depending on "
              "location and availability of products.",
            ),



            section(
              "Returns and Refunds",

              "Returns and refunds will be processed "
              "according to LAG Clothing return policy.",
            ),



            section(
              "User Responsibility",

              "Customers are responsible for providing "
              "accurate information during checkout.",
            ),



            section(
              "Contact",

              "For any questions regarding these terms, "
              "please contact LAG Clothing support.",
            ),


          ],
        ),
      ),
    );
  }



  Widget section(
      String title,
      String description,
      ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 25),


      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,


        children: [


          Text(

            title,

            style: const TextStyle(

              color:
                  Colors.redAccent,

              fontSize: 20,

              fontWeight:
                  FontWeight.bold,

            ),
          ),



          const SizedBox(height: 8),



          Text(

            description,

            style: const TextStyle(

              color:
                  Colors.white70,

              height: 1.6,

              fontSize: 15,

            ),
          ),

        ],
      ),
    );
  }
}