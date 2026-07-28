import 'package:flutter/material.dart';


class TrackingStep extends StatelessWidget {


  final String title;
  final String subtitle;
  final bool completed;
  final bool active;


  const TrackingStep({

    super.key,

    required this.title,

    required this.subtitle,

    required this.completed,

    required this.active,

  });



  @override
  Widget build(BuildContext context) {


    return Row(

      crossAxisAlignment:
      CrossAxisAlignment.start,


      children: [


        Column(

          children: [


            Container(

              height:22,

              width:22,


              decoration: BoxDecoration(

                shape:
                BoxShape.circle,

                color:

                completed || active

                    ? Colors.white

                    : Colors.grey,

              ),


            ),


            Container(

              height:60,

              width:2,


              color:

              completed

                  ? Colors.white

                  : Colors.grey,

            ),

          ],

        ),



        const SizedBox(
          width:15,
        ),



        Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [


              Text(

                title,

                style:
                TextStyle(

                  color:
                  Colors.white,

                  fontSize:18,

                  fontWeight:
                  active

                      ? FontWeight.bold

                      : FontWeight.normal,

                ),

              ),



              const SizedBox(
                height:5,
              ),



              Text(

                subtitle,

                style:
                const TextStyle(

                  color:
                  Colors.grey,

                ),

              ),



              const SizedBox(
                height:20,
              ),


            ],

          ),

        )

      ],

    );


  }

}