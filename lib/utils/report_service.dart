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
cleanReport() {
  var dbUtils = new DbUtils();
  dbUtils.clearReport();
}

saveUser(UserModel user) async {
  var dbUtils = DbUtils();
  var existingReports = await dbUtils.getUserById(user.id);
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
  if (rawUser.length > 0) {
    return UserModel.fromMapObject(rawUser[0]);
  } else {
    return null;
  }
}

/* *
* Store some sample report for validation
* */

  saveDummy() {
    saveReport(new ScannerModel(
        eanCode: "234U"));
    saveReport(new ScannerModel(
        eanCode: "222U"));
    saveReport(new ScannerModel(
        eanCode: "222U"));
    saveReport(new ScannerModel(
        eanCode: "222U"));
  }
