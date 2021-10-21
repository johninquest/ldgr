import 'dart:io';
import 'package:pdf/widgets.dart' as pd;
import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

class PrintService {
  final String downloadDir = '/storage/emulated/0/Download/';

  initializeDir() async {
    Directory tempDir = await getTemporaryDirectory();
    // String tempPath = tempDir.path;
    print('Temp directory => $tempDir');
    print('Temp path => ${tempDir.path}');
    return tempDir;
  }

  showPath() async {
    // final Directory testDir = Directory('/storage/emulated/0/Download');
    // final Directory? testDir = await getTemporaryDirectory();
    final Directory? testDir = await getExternalStorageDirectory();
    // final testDir = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;
    print(testDir);
    print(testDir!.path);
  }

  saveAsPdf() async {
    final dir = await getTemporaryDirectory();
    // final Directory? dir = await getExternalStorageDirectory();
    // final Directory dir = Directory('/storage/emulated/0/Download');
    // final dir = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;
    // final String tempPath = dir!.path;
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
    // final file = File(downloadDir + 'example.pdf');
    final file = File('${dir.path}/example.pdf');
    print(file);
    await file.writeAsBytes(await pdf.save());
    // await OpenFile.open('$file');
  }

  saveToPrinter() {}
}
