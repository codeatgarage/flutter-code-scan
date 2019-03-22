import 'package:async_loader/async_loader.dart';
import 'package:code_scann/utils/common.utils.dart';
import 'package:code_scann/fab_bottom_app_bar.dart';
import 'package:code_scann/listing_page.dart';
import 'package:code_scann/models/scanner_model.dart';
import 'package:code_scann/utils/csv_handler.dart';
import 'package:code_scann/utils/scanner_utils.dart';
import 'package:code_scann/setting_page.dart';
import 'package:code_scann/utils/report_service.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'main.dart' as main;

var bgColor = Colors.blue[800];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> homepageKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<AsyncLoaderState> listingPageKey =
      new GlobalKey<AsyncLoaderState>();

  var _selectedIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* *
   * List for holding all the pages to navigate via bottom navigation bar
   * */
  List allPages = [];
  loadAvailablePages() {
    allPages.add(CodeListing(
      listingPageKey: listingPageKey,
    ));
    allPages.add(SettingsPage());
  }

  saveCode(code) {
    ScannerModel result = new ScannerModel(eanCode: code);
    saveReport(result);
    CommonUtils.showSnackBar(homepageKey, 'Code Save!.', null);
    listingPageKey.currentState.reloadState();
  }

  /* Scan now is function to start the scanner*/
  scanNow() async {
    String result = await ScannerUtils.getBarCode();
    if (result.contains('back')) {
      CommonUtils.showSnackBar(homepageKey, 'Back button pressed.', null);
    } else if (!result.contains('Err:')) {
      saveCode(result);
    } else {
      CommonUtils.showSnackBar(
          homepageKey, 'Some thing went wrong ! please try again.', null);
    }
    listingPageKey.currentState.reloadState();
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
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.center_focus_weak,
          color: Colors.white,
        ),
        backgroundColor: bgColor,
        elevation: 2.0,
        onPressed: scanNow,
      ),
    );
  }
}
