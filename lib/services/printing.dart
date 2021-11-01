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

  personPdf() async {
    final Directory? dir = await getTemporaryDirectory();
    await SharedPreferencesHelper().readData('personData').then((value) async {
      Map parsed = DataParser().strToMap(value);
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
                      child: pw.Text('Person information',
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Surname',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsed['surname'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Given names',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsed['given_names'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Address',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsed['address'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('City / Town', style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsed['city'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Country',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(capitalizeStr((parsed['country'])),
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Phone', style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsed['phone'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('E-mail',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(parsed['email'],
                              style: pw.TextStyle(fontSize: 18)),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Role',
                              style: pw.TextStyle(fontSize: 18)),
                          pw.Text(capitalizeStr(parsed['role']),
                              style: pw.TextStyle(fontSize: 18)),
                        ]),    
                  ]),
            );
          }));
          final String fileName =
          'person_info_${parsed["surname"]}';
          final file = File('${dir!.path}/$fileName'); 
          await file.writeAsBytes(await pdf.save()); 
          await Future.delayed(Duration(seconds: 3), showGeneratedPdf(file.path));
    });
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

convertToUpperCase(String? str) {
  if (str != null && str.runtimeType == String) {
    return str.toUpperCase();
  }else {
    return '';
  }
}

capitalizeStr(String? str) {
  if (str != null && str.runtimeType == String) {
   String capitalized =  str[0].toUpperCase() + str.substring(1); 
   return capitalized;
  }else {
    return '';
  }

}
