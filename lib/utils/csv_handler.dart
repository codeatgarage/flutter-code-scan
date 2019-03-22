import 'dart:io';
import 'package:code_scann/models/user_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:code_scann/utils/report_service.dart';
import 'package:csv/csv.dart';
import 'package:code_scann/models/scanner_model.dart';
import 'package:http/http.dart' as http;

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
    row.add(timeHolder[1]);
    row.add(timeHolder[0]);
    codeListHolder.add(row);
  }
  String reportCsv = const ListToCsvConverter().convert(codeListHolder);
  return await writeCsvToFile(reportCsv);
}

submitReport() async {
  UserModel user = await loadUser();
  if(user == null ){
    return 'userNotFound';
  }
  var reportSaveUrl = Uri.parse("https://homecaresoft.cz/indata/in.php");
  var request = new http.MultipartRequest("POST", reportSaveUrl);
  var csvFile = await processListToCsv();

  request.fields['clientid'] = user.clientId;
  request.fields['username'] = user.userName;
  request.fields['password'] = user.password;

  request.files.add(new http.MultipartFile.fromBytes('report.txt', await csvFile.readAsBytes(),
      contentType: new MediaType('application', 'octet-stream')));
  http.StreamedResponse response = await request.send();
  if(response.statusCode == 200 && response.reasonPhrase == 'OK') {
     csvFile.delete();
     return true;
  } else {
     return null;
  }
}