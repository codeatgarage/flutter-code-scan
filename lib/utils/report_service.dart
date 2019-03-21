import 'package:code_scann/models/scanner_model.dart';
import 'package:code_scann/utils/db_utils..dart';

Future loadReports() async {
  var dbUtils = new DbUtils();
  var reportsList = await dbUtils.getReports();
  int len = reportsList.length;
  List<ScannerModel> reports = List<ScannerModel>();
  for (int i = 0; i < len; i++) {
    reports.add(ScannerModel.fromMapObject(reportsList[i]));
  }
  return reports;
}

/* *
* Save report to db if already exist then exclude the function
* */

saveReport(ScannerModel scanData) async {
  var dbUtils = DbUtils();
  var existingReports = await dbUtils.getReportByEan(scanData.eanCode);
  if (existingReports.length == 0) {
    return dbUtils.saveReport(scanData);
  } else {
    return null;
  }
}

/* *
* Remove scan item
* * */
deleteReport(id) {
  var dbUtils = new DbUtils();
  dbUtils.deleteReport(id);
}

/* *
 * Flush out the db table when execution is done.
 * */
cleanCart() {
  var dbUtils = new DbUtils();
  dbUtils.clearReport();
}