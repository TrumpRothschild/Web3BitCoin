import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:flutter/services.dart';
// void main() => runApp(const WhitePaperPage());

class WhitePaperPage extends StatefulWidget {
  const WhitePaperPage({Key? key}) : super(key: key);

  @override
  _WhitePaperPageState createState() => _WhitePaperPageState();
}

class _WhitePaperPageState extends State<WhitePaperPage> {
  static const int _initialPage = 20;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    initPdf();
    super.dispose();
  }
  void initPdf() async {
    final document = await PdfDocument.openAsset('assets/BlockchainTechnologies.pdf');
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: page.height);
    await page.close();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(

    home: Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('PdfView example'),

      ),
      body: Center(
        // child: Image(
          // image: MemoryImage(pageImage!.bytes),
        // ),
      ),
    ),
  );
}