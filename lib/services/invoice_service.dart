import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/order_model.dart';

import '../features/invoice/invoice_customer_card.dart';
import '../features/invoice/invoice_footer.dart';
import '../features/invoice/invoice_header.dart';
import '../features/invoice/invoice_payment_card.dart';
import '../features/invoice/invoice_product_table.dart';
import '../features/invoice/invoice_summary.dart';
import '../features/invoice/invoice_theme.dart';

class InvoiceService {
  InvoiceService._();

  //==========================================================
  // Generate Invoice
  //==========================================================

  static Future<Uint8List> generateInvoice(
    OrderModel order,
  ) async {
    final logoData = await rootBundle.load(
      'assets/images/logo.png',
    );

    final logoBytes =
        logoData.buffer.asUint8List();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),

        build: (context) {
          return [

            //--------------------------------------------------
            // Header
            //--------------------------------------------------

            InvoiceHeader(
              order: order,
              logo: logoBytes,
            ),

            pw.SizedBox(height: 24),

            //--------------------------------------------------
            // Customer
            //--------------------------------------------------

            InvoiceCustomerCard(
              order: order,
            ),

            pw.SizedBox(height: 24),

            //--------------------------------------------------
            // Product Table
            //--------------------------------------------------

            InvoiceProductTable(
              order: order,
            ),

            pw.SizedBox(height: 24),

            //--------------------------------------------------
            // Invoice Summary
            //--------------------------------------------------

            InvoiceSummary(
              order: order,
            ),

            pw.SizedBox(height: 24),

            //--------------------------------------------------
            // Payment
            //--------------------------------------------------

            InvoicePaymentCard(
              order: order,
            ),

            pw.SizedBox(height: 30),

            //--------------------------------------------------
            // Footer
            //--------------------------------------------------

             InvoiceFooter(),
          ];
        },
      ),
    );

    return pdf.save();
  }

  //==========================================================
  // Print Invoice
  //==========================================================

  static Future<void> printInvoice(
    OrderModel order,
  ) async {
    await Printing.layoutPdf(
      onLayout: (_) async =>
          generateInvoice(order),
    );
  }

  //==========================================================
  // Download / Share Invoice
  //==========================================================

  static Future<void> downloadInvoice(
    OrderModel order,
  ) async {
    final bytes =
        await generateInvoice(order);

    await Printing.sharePdf(
      bytes: bytes,
      filename:
          "Invoice-${order.orderNumber}.pdf",
    );
  }
}