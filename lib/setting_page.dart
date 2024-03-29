import 'package:code_scann/models/user_model.dart';
import 'package:code_scann/utils/common.utils.dart';
import 'package:code_scann/utils/csv_handler.dart';
import 'package:code_scann/utils/report_service.dart';
import 'package:flutter/material.dart';

var bgColor = Colors.blue[800];
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<ScaffoldState> settingsPageKey = new GlobalKey<ScaffoldState>();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _clientIdController = new TextEditingController();
  UserModel userProfile;
  bool _isLoading = false;

  startLoading() {
    if(this.mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  stopLoading() {
    if(this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  sendReport() async {
    startLoading();
    var result = await submitReport();
    print(result);
    if(result == null) {
      CommonUtils.showSnackBar(
          settingsPageKey, 'Some thing went wrong ! please try again.', null, true);
    } else if(result == 'userNotFound') {
      CommonUtils.showSnackBar(
          settingsPageKey, 'Invalid User, Please save user details!', null, true);
    } else if(result == 'nodata') {
      CommonUtils.showSnackBar(
          settingsPageKey, 'No data found!', null, true);
    } else if(result == false) {
      CommonUtils.showSnackBar(
          settingsPageKey, null, null, true);
    }
    else {
      CommonUtils.showSnackBar(
          settingsPageKey, 'Successfully send to server!', null, true);
      cleanReport();
    }
    stopLoading();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: settingsPageKey,
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0.0,
        backgroundColor: bgColor,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid)),
                child: IconButton(
                  icon: Icon(Icons.person_outline),
                  iconSize: 40.0,
                  color: Colors.blueAccent,
                  onPressed: () {
                    showFormDialog();
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid)),
                child: IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 40.0,
                  color: Colors.blueAccent,
                  onPressed: _isLoading ? null : () { sendReport(); },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showFormDialog() async {
    UserModel initialValue = await loadUser();
    _userNameController.text =
        (initialValue != null) ? initialValue.userName : '';
    _passwordController.text =
        (initialValue != null) ? initialValue.password : '';
    _clientIdController.text =
        (initialValue != null) ? initialValue.clientId : '';

    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('User information'),
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      controller: _clientIdController,
                      decoration: new InputDecoration(
                          labelText: 'Client Id', hintText: 'eg. 123456'),
                    ),
                    TextField(
                      autofocus: true,
                      controller: _userNameController,
                      decoration: new InputDecoration(
                          labelText: 'User Name', hintText: 'eg. John Smith'),
                    ),
                    TextField(
                      autofocus: true,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: new InputDecoration(
                          labelText: 'Password', hintText: '******'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("Cancel"),
                  ),
                  new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () async {
                      String clientId = _clientIdController.text;
                      String userName = _userNameController.text;
                      String password = _passwordController.text;
                      UserModel userValue = new UserModel(
                          userName: userName,
                          clientId: clientId,
                          password: password,
                          id: (initialValue != null) ? initialValue.id : null);
                      print(userValue);
                      print(userName);
                      print(clientId);
                      print(password);
                      await saveUser(userValue);
                      Navigator.pop(context);
                    },
                    child: new Text(
                      "Save",
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
