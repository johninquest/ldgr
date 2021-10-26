import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:tba/services/date_time_helper.dart';

class PrintService {

  generatePdf() async {
    final Directory? dir = await getTemporaryDirectory();
    // final Directory? dir = await getExternalStorageDirectory();
    // final Directory? dir = Directory('/storage/emulated/0/Download');
    // final dir = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;
    // final String tempPath = dir!.path;
    print('Temp directory => $dir');
    print('Temp path => ${dir!.path}');
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Leben und leben lassen - F. von Schiller'),
          );
        }));
    final String fileName =
        'phita_${DateTimeHelper().timestampAsString(DateTime.now())}.pdf';
    final file = File('${dir.path}/$fileName');
    print(file);
    print('PDF location => ${file.path}');
    await file.writeAsBytes(await pdf.save());
    await Future.delayed(Duration(seconds: 3), showGeneratedPdf(file.path));
  }

  showGeneratedPdf(String? givenPath) {
    if(givenPath.runtimeType == String) {
      OpenFile.open(givenPath);
    } 
  }
}
