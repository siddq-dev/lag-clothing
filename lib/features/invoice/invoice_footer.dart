import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/constants/company_info.dart';
import '../invoice/invoice_theme.dart';

class InvoiceFooter extends pw.StatelessWidget {
  InvoiceFooter();

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: double.infinity,

      padding: const pw.EdgeInsets.all(18),

      decoration: pw.BoxDecoration(
        color: InvoiceTheme.light,
        border: pw.Border.all(
          color: InvoiceTheme.border,
        ),
      ),

      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [

          pw.Text(
            "Thank You For Shopping With ${CompanyInfo.companyName}",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Text(
            CompanyInfo.tagline,
            style: pw.TextStyle(
              color: InvoiceTheme.secondary,
            ),
          ),

          pw.SizedBox(height: 12),

          pw.Text(CompanyInfo.website),

          pw.Text(CompanyInfo.email),

          pw.Text(CompanyInfo.phone),

          pw.Text(CompanyInfo.address),

          pw.SizedBox(height: 18),

          pw.Divider(),

          pw.SizedBox(height: 8),

          pw.Text(
            "Returns accepted within 7 days from delivery.",
            style: const pw.TextStyle(
              fontSize: 10,
            ),
          ),

          pw.SizedBox(height: 4),

          pw.Text(
            "Please keep this invoice for warranty and return purposes.",
            style: const pw.TextStyle(
              fontSize: 10,
            ),
          ),

          pw.SizedBox(height: 14),

          pw.Text(
            "© ${DateTime.now().year} ${CompanyInfo.companyName}",
            style: pw.TextStyle(
              color: PdfColors.grey700,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}