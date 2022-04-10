import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PdfViewScreen extends StatelessWidget {
  final String fileUrl;
  const PdfViewScreen({Key? key, required this.fileUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
          body: Container(
              child: SfPdfViewer.network(fileUrl)));
  }
}
