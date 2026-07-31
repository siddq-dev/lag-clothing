import 'package:pdf/widgets.dart' as pw;

import '../../../models/order_model.dart';
import '../invoice/invoice_theme.dart';

class InvoiceCustomerCard extends pw.StatelessWidget {
  InvoiceCustomerCard({
    required this.order,
  });

  final OrderModel order;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        //------------------------------------------------
        // Billing Address
        //------------------------------------------------

        pw.Expanded(
          child: _addressCard(
            title: "Billing Address",
            address: order.billingAddress,
          ),
        ),

        pw.SizedBox(width: 20),

        //------------------------------------------------
        // Shipping Address
        //------------------------------------------------

        pw.Expanded(
          child: _addressCard(
            title: "Shipping Address",
            address: order.shippingAddress,
          ),
        ),
      ],
    );
  }

  pw.Widget _addressCard({
    required String title,
    required dynamic address,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: InvoiceTheme.border,
        ),
      ),

      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          pw.Text(
            title,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Text(
            address.fullName,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Text(address.phone),

          pw.SizedBox(height: 6),

          pw.Text(address.addressLine1),

          if (address.addressLine2.isNotEmpty)
            pw.Text(address.addressLine2),

          pw.Text(
            "${address.city}, ${address.state}",
          ),

          pw.Text(
            "${address.country} - ${address.pincode}",
          ),
        ],
      ),
    );
  }
}