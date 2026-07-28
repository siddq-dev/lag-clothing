import 'package:flutter/material.dart';


class DownloadInvoiceButton extends StatelessWidget {

  const DownloadInvoiceButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      onPressed: (){

        // PDF generation later

      },

      child:
      const Text(
        "Download Invoice",
      ),

    );

  }

}