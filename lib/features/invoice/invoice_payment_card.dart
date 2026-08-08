import 'package:pdf/widgets.dart' as pw;

import '../../../models/order_model.dart';
import '../invoice/invoice_theme.dart';

class InvoicePaymentCard extends pw.StatelessWidget {
  InvoicePaymentCard({required this.order});

  final OrderModel order;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(18),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: InvoiceTheme.border),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Payment Information",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
          ),

          pw.SizedBox(height: 15),

          _infoRow("Payment Method", order.paymentMethod),

          _infoRow("Payment Status", order.paymentStatus.name.toUpperCase()),

          _infoRow("Order Status", order.orderStatus.name.toUpperCase()),

          _infoRow(
            "Tracking ID",
            order.trackingId.isEmpty ? "-" : order.trackingId,
          ),

          _infoRow("Generated", DateTime.now().toString().split(" ").first),
        ],
      ),
    );
  }

  pw.Widget _infoRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              title,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),

          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }
}
