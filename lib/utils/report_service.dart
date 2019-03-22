import 'package:code_scann/models/scanner_model.dart';
import 'package:code_scann/models/user_model.dart';
import 'package:code_scann/utils/db_utils.dart';

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
  return dbUtils.saveReport(scanData);
  /*var existingReports = await dbUtils.getReportByEan(scanData.eanCode);
  if (existingReports.length == 0) {
    return dbUtils.saveReport(scanData);
  } else {
    return null;
  }*/
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

saveUser(UserModel user) async {
  var dbUtils = DbUtils();
  var existingReports = await dbUtils.getReportByEan(user.id);
  if (existingReports.length == 0) {
    return dbUtils.saveUser(user);
  } else {
    return dbUtils.updateUser(user);
  }
}

/* *
* Load user details
* */

Future loadUser() async {
  var dbUtils = new DbUtils();
  var rawUser = await dbUtils.getUser();
  return UserModel.fromMapObject(rawUser[0]);
}

/* *
* Store some sample report for validation
* */

/*
  saveDummy() {
    saveReport(new ScannerModel(
        eanCode: "234U",
        cDate: formatDate(
            DateTime.now(), [dd, '/', mm, '/', yy, '-', HH, ':', nn])));
    saveReport(new ScannerModel(
        eanCode: "222U",
        cDate: formatDate(
            DateTime.now(), [dd, '/', mm, '/', yy, '-', HH, ':', nn])));
    saveReport(new ScannerModel(
        eanCode: "233333U",
        cDate: formatDate(
            DateTime.now(), [dd, '/', mm, '/', yy, '-', HH, ':', nn])));
    saveReport(new ScannerModel(
        eanCode: "55555U",
        cDate: formatDate(
            DateTime.now(), [dd, '/', mm, '/', yy, '-', HH, ':', nn])));
  }
*/
