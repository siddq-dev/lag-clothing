import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/order_model.dart';
import '../invoice/invoice_theme.dart';

class InvoiceSummary extends pw.StatelessWidget {
  InvoiceSummary({required this.order});

  final OrderModel order;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Container(
        width: 280,

        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: InvoiceTheme.border),
        ),

        child: pw.Column(
          children: [
            //--------------------------------------------------
            // Header
            //--------------------------------------------------
            pw.Container(
              width: double.infinity,

              padding: const pw.EdgeInsets.all(10),

              color: InvoiceTheme.primary,

              child: pw.Center(
                child: pw.Text(
                  "Invoice Summary",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            pw.Padding(
              padding: const pw.EdgeInsets.all(14),

              child: pw.Column(
                children: [
                  _row("Subtotal", order.subtotal),

                  _row("Shipping", order.shippingCharge),

                  _row("Discount", order.discount),

                  _row("Tax", order.tax),

                  pw.Divider(),

                  _row("Grand Total", order.total, bold: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------------
  // Row
  //--------------------------------------------------------

  pw.Widget _row(String title, double amount, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),

      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

        children: [
          pw.Text(
            title,
            style: bold
                ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
                : const pw.TextStyle(),
          ),

          pw.Text(
            "₹${amount.toStringAsFixed(2)}",
            style: bold
                ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
                : const pw.TextStyle(),
          ),
        ],
      ),
    );
  }
}
