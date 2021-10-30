import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:tba/db/sp_helper.dart';
import 'package:tba/services/currency.dart';
import 'package:tba/services/date_time_helper.dart';
import 'package:tba/services/preprocessor.dart';

class PrintService {
  generatePdf() async {
    final Directory? dir = await getTemporaryDirectory();
    /* final Directory? dir = await getExternalStorageDirectory();
    final Directory? dir = Directory('/storage/emulated/0/Download');
    final dir = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;
    print('Temp directory => $dir');
    print('Temp path => ${dir!.path}'); */
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
    final file = File('${dir!.path}/$fileName');
    print(file);
    print('PDF location => ${file.path}');
    await file.writeAsBytes(await pdf.save());
    await Future.delayed(Duration(seconds: 3), showGeneratedPdf(file.path));
    // vehiclePdf();
  }

  showGeneratedPdf(String? givenPath) {
    if (givenPath.runtimeType == String) {
      OpenFile.open(givenPath);
    } else {
      print('Path to file not valid!');
    }
  }

  vehiclePdf() async {
    final Directory? dir = await getTemporaryDirectory();
    String? currencyValue;
    await CurrencyHandler()
        .getCurrencyData()
        .then((value) => currencyValue = value);
    await SharedPreferencesHelper().readData('vehicleData').then((value) async {
      Map parsedData = DataParser().strToMap(value);
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Container(
                      margin: pw.EdgeInsets.only(bottom: 20.0),
                      child: pw.Text('Vehicle information',
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('License plate number',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsedData['licensePlateNumber'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Chassis number',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsedData['chassisNumber'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Manufacturer',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(convertToUpperCase(parsedData['maker']),
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Model', style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsedData['model'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('First registration date',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsedData['firstRegistrationDate'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Age', style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsedData['age'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Purchase price',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(
                              '$currencyValue ${parsedData["purchasePrice"]}',
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                  ]),
            );
          }));
/*       final String fileName =
          '${DateTimeHelper().timestampAsString(DateTime.now())}.pdf'; */
      final String fileName =
          'vehicle_info_${parsedData["licensePlateNumber"]}';
      final file = File('${dir!.path}/$fileName');
      await file.writeAsBytes(await pdf.save());
      await Future.delayed(Duration(seconds: 3), showGeneratedPdf(file.path));
    });
  }
}

convertToUpperCase(String? data) {
  if (data != null && data.runtimeType == String) {
    return data.toUpperCase();
  }
}