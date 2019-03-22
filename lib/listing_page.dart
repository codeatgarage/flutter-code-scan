import 'package:async_loader/async_loader.dart';
import 'package:code_scann/models/scanner_model.dart';
import 'package:code_scann/utils/report_service.dart';
import 'package:flutter/material.dart';

var bgColor = Colors.blue[800];

class CodeListing extends StatefulWidget {
  final listingPageKey;
  CodeListing({this.listingPageKey});
  @override
  _CodeListingState createState() => _CodeListingState();
}

class _CodeListingState extends State<CodeListing> {
  Widget buildTileListItems(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          ScannerModel scanItem = data[index];
          return ListTile(
            leading: Icon(Icons.center_focus_strong, color: Colors.green[200]),
            title: Text(
              scanItem.eanCode,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
            subtitle: Text("${scanItem.cDate}"),
            trailing: (index == 0)
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      deleteReport(scanItem.id);
                      onRefresh();
                    },
                    color: Colors.red[400],
                  )
                : SizedBox(
                    width: 10.0,
                  ),
          );
        },
      );
    } else {
      return Container(
        child: Center(
          child: Text(
            'NO DATA FOUND',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
  }

  buildLoader() {
    return CircularProgressIndicator();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() {
    return widget.listingPageKey.currentState.reloadState();
  }

  @override
  Widget build(BuildContext context) {
    var asyncReportLoader = new AsyncLoader(
      key: widget.listingPageKey,
      initState: () async => await loadReports(),
      renderLoad: () => buildLoader(),
      renderSuccess: ({data}) => buildTileListItems(data),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Code List'),
        elevation: 0.0,
        backgroundColor: bgColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: onRefresh,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Center(child: asyncReportLoader),
      ),
    );
  }
}
