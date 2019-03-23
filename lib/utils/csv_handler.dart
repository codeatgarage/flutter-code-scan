import 'dart:io';
import 'package:code_scann/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:code_scann/utils/report_service.dart';
import 'package:csv/csv.dart';
import 'package:code_scann/models/scanner_model.dart';
import 'package:dio/dio.dart';

// load local path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  var currentDate = DateTime.now();
  return File('$path/reports_${currentDate.millisecondsSinceEpoch}.txt');
}

Future<File> writeCsvToFile(String reportData) async {
  final file = await _localFile;
  return file.writeAsString('$reportData');
}

Future<File> processListToCsv() async {
  List<List<dynamic>> codeListHolder = List<List<dynamic>>();
  List<ScannerModel> scannerList = List<ScannerModel>();
  scannerList = await loadReports();
  for (int i = 0; i < scannerList.length; i++) {
    List<dynamic> row = List();
    List<dynamic> timeHolder = scannerList[i].cDate.split(' ');
    row.add(scannerList[i].eanCode);
    row.add('Code-128');
    row.add(timeHolder[1]);
    row.add(timeHolder[0]);
    codeListHolder.add(row);
  }
  String reportCsv = const ListToCsvConverter().convert(codeListHolder);
  return await writeCsvToFile(reportCsv);
}

submitReport() async {
  try {
    UserModel user = await loadUser();
    if(user == null ){
      return 'userNotFound';
    }
    var csvFile = await processListToCsv();
    var len = await csvFile.length();
    if(len == 0) {
      return 'nodata';
    }

    Dio dio = new Dio();
    var currentDate = DateTime.now();
    FormData formData = FormData.from({
      "clientid": user.clientId,
      "userName": user.userName,
      "password": user.password,
      "files": [
        UploadFileInfo(csvFile, "reports_${currentDate.millisecondsSinceEpoch}.txt"),
      ]
    });

    var response = await dio.post("https://homecaresoft.cz/indata/inres.php",
      data: formData,
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      }
    );
    csvFile.delete();
    return response;
  } catch (e) {
    return false;
  }
}