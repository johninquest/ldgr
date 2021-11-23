import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:rba/db/sp_helper.dart';
import 'package:rba/db/sqlite_helper.dart';
import 'package:rba/services/currency.dart';
import 'package:rba/services/preprocessor.dart';
import 'package:rba/shared/snackbar_messages.dart';

class PrintService {

  showGeneratedPdf(String? givenPath) {
    if (givenPath.runtimeType == String) {
      OpenFile.open(givenPath);
    } else {
      print('Path to file not valid!');
    }
  }

  personPdf(appContext) async {
    /*   final Directory? dir = await getTemporaryDirectory(); */
    await SharedPreferencesHelper().readData('personData').then((value) async {
      if (value != null) {
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
                        margin: pw.EdgeInsets.only(bottom: 10.0),
                        child: pw.Text('Person information',
                            style: pw.TextStyle(
                                fontSize: 20, fontWeight: pw.FontWeight.bold)),
                      ), 
                      pw.Container(
                        margin: pw.EdgeInsets.only(bottom: 10.0), 
                        child: pw.Divider(
                          color: PdfColor.fromHex('#0046A1'), thickness: 3.0),
                      ),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Surname',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsed['surname'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                       pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),      
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Given names',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsed['given_names'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),      
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Address',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsed['address'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),      
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('City / Town',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsed['city'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),      
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Phone', style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsed['phone'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]), 
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),      
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('E-mail',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsed['email'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),      
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Role', style: pw.TextStyle(fontSize: 18)),
                            pw.Text(capitalizeStr(parsed['role']),
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'), thickness: 1.0),
                    ]),
              );
            }));
        final Directory? dir = await getTemporaryDirectory();
        final String fileName = 'person_info_${parsed["surname"]}';
        File file = File('${dir!.path}/$fileName');
        await file.writeAsBytes(await pdf.save());
        await Future.delayed(Duration(seconds: 3), await showGeneratedPdf(file.path));
      } else {
        return SnackBarMessage().generalErrorMessage(appContext);
      }
    });
  }

  vehiclePdf(appContext) async {
    String? currencyValue;
    await CurrencyHandler()
        .getCurrencyData()
        .then((value) => currencyValue = value);
    await SharedPreferencesHelper().readData('vehicleData').then((value) async {
      if (value != null) {
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
                        margin: pw.EdgeInsets.only(bottom: 10.0),
                        child: pw.Text('Vehicle information',
                            style: pw.TextStyle(
                                fontSize: 20, fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Container(
                        margin: pw.EdgeInsets.only(bottom: 10.0),
                        child: pw.Divider(
                          color: PdfColor.fromHex('#0046A1'), thickness: 3.0),),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('License plate number',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsedData['licensePlateNumber'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),    
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Chassis number',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsedData['chassisNumber'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]), 
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),    
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Manufacturer',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(convertToUpperCase(parsedData['maker']),
                                style: pw.TextStyle(fontSize: 18)),
                          ]), 
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),    
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Model', style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsedData['model'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]), 
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),    
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('First registration date',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsedData['firstRegistrationDate'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]), 
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),    
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Age', style: pw.TextStyle(fontSize: 18)),
                            pw.Text(parsedData['age'],
                                style: pw.TextStyle(fontSize: 18)),
                          ]), 
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),    
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Purchase price',
                                style: pw.TextStyle(fontSize: 18)),
                            pw.Text(
                                '$currencyValue ${parsedData["purchasePrice"]}',
                                style: pw.TextStyle(fontSize: 18)),
                          ]),
                      pw.Divider(
                          color: PdfColor.fromHex('#0046A1'),),
                      /*  pw.Container(
                          margin: pw.EdgeInsets.only(top: 200.0),
                          child: pw.Text('Generated with the phita app')), */
                    ]),
              );
            }));

        final Directory? dir = await getTemporaryDirectory();
        final String fileName =
            'vehicle_info_${parsedData["licensePlateNumber"]}';
        File file = File('${dir!.path}/$fileName');
        await file.writeAsBytes(await pdf.save());
        await Future.delayed(Duration(seconds: 3), await showGeneratedPdf(file.path));
      } else {
        return SnackBarMessage().generalErrorMessage(appContext);
      }
    });
  }

  recordsPdf(String period, context) async {
    String? currencyValue;
    await CurrencyHandler()
        .getCurrencyData()
        .then((value) => currencyValue = value);
    print('Current currency => $currencyValue');
    SQLiteDatabaseHelper().getAllRowsToday().then((value) => print(value));
  }
}

convertToUpperCase(String? str) {
  if (str != null && str.runtimeType == String) {
    return str.toUpperCase();
  } else {
    return '';
  }
}

capitalizeStr(String? str) {
  if (str != null && str.runtimeType == String) {
    String capitalized = str[0].toUpperCase() + str.substring(1);
    return capitalized;
  } else {
    return '';
  }
}
