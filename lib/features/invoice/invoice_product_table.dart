import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/order_model.dart';
import '../invoice/invoice_theme.dart';

class InvoiceProductTable extends pw.StatelessWidget {
  InvoiceProductTable({
    required this.order,
  });

  final OrderModel order;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          "Ordered Items",
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 12),

        pw.Table(
          border: pw.TableBorder.all(
            color: InvoiceTheme.border,
          ),

          columnWidths: {
            0: const pw.FlexColumnWidth(4),
            1: const pw.FlexColumnWidth(1.2),
            2: const pw.FlexColumnWidth(1.5),
            3: const pw.FlexColumnWidth(1),
            4: const pw.FlexColumnWidth(1.6),
            5: const pw.FlexColumnWidth(1.6),
          },

          children: [

            //------------------------------------------------------
            // Header
            //------------------------------------------------------

            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              children: [

                _header("Product"),

                _header("Size"),

                _header("Color"),

                _header("Qty"),

                _header("Price"),

                _header("Total"),

              ],
            ),

            //------------------------------------------------------
            // Products
            //------------------------------------------------------

            ...order.items.map(
              (item) {
                return pw.TableRow(
                  children: [

                    _cell(item.productName),

                    _cell(item.size),

                    _cell(item.color),

                    _cell(
                      item.quantity.toString(),
                      align: pw.Alignment.center,
                    ),

                    _cell(
                      "₹${item.price.toStringAsFixed(2)}",
                      align: pw.Alignment.centerRight,
                    ),

                    _cell(
                      "₹${item.total.toStringAsFixed(2)}",
                      align: pw.Alignment.centerRight,
                    ),

                  ],
                );
              },
            ),

          ],
        ),

      ],
    );
  }

  //------------------------------------------------------
  // Header Cell
  //------------------------------------------------------

  pw.Widget _header(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  //------------------------------------------------------
  // Body Cell
  //------------------------------------------------------

  pw.Widget _cell(
    String text, {
    pw.Alignment align = pw.Alignment.centerLeft,
  }) {
    return pw.Container(
      alignment: align,
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
      ),
    );
  }
}