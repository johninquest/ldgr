import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pd;
import 'package:path_provider/path_provider.dart';

class PrintService {
  initializeDir() async {
    Directory tempDir = await getTemporaryDirectory();
    // String tempPath = tempDir.path;
    print('Temp directory => $tempDir');
    print('Temp path => ${tempDir.path}');
    return tempDir;
  }
  
  saveAsPdf() async {
    final dir = await getTemporaryDirectory();
    print('Temp directory => $dir');
    print('Temp path => ${dir.path}');
    final pdf = pd.Document();
    pdf.addPage(
      pd.Page(
        build: (pd.Context context) => pd.Center(
          child: pd.Text('Hello World!'),
        ),
      ),
    );
    // final file = File('example.pdf');
    final file = File('${dir.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  saveToPrinter() {}
}
