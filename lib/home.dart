import 'package:code_scann/common.utils.dart';
import 'package:code_scann/fab_bottom_app_bar.dart';
import 'package:code_scann/listing_page.dart';
import 'package:code_scann/models/scanner_model.dart';
import 'package:code_scann/scanner_utils.dart';
import 'package:code_scann/setting_page.dart';
import 'package:code_scann/utils/report_service.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

var bgColor = Colors.blue[800];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> homepageKey = new GlobalKey<ScaffoldState>();
  var _selectedIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* *
   * List for holding all the pages to navigate via bottom navigation bar
   * */
  List allPages =[];
  loadAvailablePages() {
    allPages.add(CodeListing());
    allPages.add(SettingsPage());
  }

  saveCode(code) {
//    String scanDate = DateTime.now().toIso8601String();
    String scanDate = formatDate(DateTime.now(), [dd,'/',mm,'/',yy,'-',HH,':',nn]);
    ScannerModel result = new ScannerModel(eanCode: code, cDate: scanDate);
    saveReport(result);
    CommonUtils.showSnackBar(homepageKey, 'Code Save!.', null);
  }

  /* Scan now is function to start the scanner*/
  scanNow() async {
    String result = await ScannerUtils.getBarCode();
    if(result.contains('back')) {
      CommonUtils.showSnackBar(homepageKey, 'Back button pressed.', null);
    } else if (!result.contains('Err:')) {
      saveCode(result);
    } else {
      CommonUtils.showSnackBar(homepageKey, 'Some thing went wrong ! please try again.', null);
    }
  }


  @override
  void initState() {
    super.initState();
    loadAvailablePages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homepageKey,
      body: allPages.elementAt(_selectedIndex),
      bottomNavigationBar: FABBottomAppBar(
          centerItemText: 'Scan',
          color: Colors.black,
          selectedColor: bgColor,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'home'),
            FABBottomAppBarItem(iconData: Icons.settings, text: 'setting')
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_weak, color: Colors.white,),
        backgroundColor: bgColor,
        elevation: 2.0,
        onPressed: scanNow,
      ),
    );
  }

}
