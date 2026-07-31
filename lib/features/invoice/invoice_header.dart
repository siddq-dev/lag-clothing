import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/company_info.dart';
import '../invoice/invoice_theme.dart';
import '../../../models/order_model.dart';

class InvoiceHeader extends pw.StatelessWidget {
  InvoiceHeader({
    required this.order,
    required this.logo,
  });

  final OrderModel order;
  final Uint8List logo;

  @override
  @override
pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: InvoiceTheme.border,
        ),
      ),

      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          //------------------------------------------------
          // Logo
          //------------------------------------------------

          pw.Container(
            width: 90,
            height: 90,
            child: pw.Image(
              pw.MemoryImage(logo),
              fit: pw.BoxFit.contain,
            ),
          ),

          pw.SizedBox(width: 20),

          //------------------------------------------------
          // Company Details
          //------------------------------------------------

          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment:
                  pw.CrossAxisAlignment.start,
              children: [

                pw.Text(
                  CompanyInfo.companyName,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: InvoiceTheme.primary,
                  ),
                ),

                pw.SizedBox(height: 4),

                pw.Text(
                  CompanyInfo.tagline,
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: InvoiceTheme.secondary,
                  ),
                ),

                pw.SizedBox(height: 12),

                pw.Text(
                  CompanyInfo.website,
                ),

                pw.Text(
                  CompanyInfo.email,
                ),

                pw.Text(
                  CompanyInfo.phone,
                ),

                pw.Text(
                  CompanyInfo.address,
                ),
              ],
            ),
          ),

          //------------------------------------------------
          // Invoice Details
          //------------------------------------------------

          pw.Column(
            crossAxisAlignment:
                pw.CrossAxisAlignment.end,
            children: [

              pw.Text(
                "INVOICE",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              _detail(
                "Invoice No",
                order.orderNumber,
              ),

              _detail(
                "Tracking ID",
                order.trackingId.isEmpty
                    ? "-"
                    : order.trackingId,
              ),

              _detail(
                "Date",
                order.createdAt == null
                    ? "-"
                    : order.createdAt!
                        .toDate()
                        .toString()
                        .split(" ")
                        .first,
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _detail(
    String title,
    String value,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        bottom: 6,
      ),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [

          pw.Text(
            "$title : ",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Text(value),

        ],
      ),
    );
  }
}