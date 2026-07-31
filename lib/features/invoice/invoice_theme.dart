import 'package:pdf/pdf.dart';

class InvoiceTheme {
  InvoiceTheme._();

  static const PdfColor primary =
      PdfColor.fromInt(0xFF000000);

  static const PdfColor secondary =
      PdfColor.fromInt(0xFF444444);

  static const PdfColor light =
      PdfColor.fromInt(0xFFF5F5F5);

  static const PdfColor border =
      PdfColor.fromInt(0xFFE5E5E5);

  static const PdfColor success =
      PdfColor.fromInt(0xFF2E7D32);

  static const PdfColor warning =
      PdfColor.fromInt(0xFFF9A825);

  static const PdfColor danger =
      PdfColor.fromInt(0xFFC62828);
}