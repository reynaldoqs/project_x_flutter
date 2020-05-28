import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<String> _getToken() async {
    String token = await _fcm.getToken();
    return token;
  }

  String message;

  _makePostRequest() async {
    String url = 'http://192.168.42.48:8080/cresolvers';
    Map<String, String> headers = {"Content-type": "application/json"};

    String token = await _getToken();

    String json =
        '{"phoneNumber":78815232,"company":"tigo","xDay":22,"msgToken":"$token","notify": false}';

    Response response = await post(url, headers: headers, body: json);

    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
    setState(() {
      message = response.body.toString();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Do it'),
              onPressed: _makePostRequest,
            ),
            Text('resp: $message'),
          ],
        ),
      ),
    );
  }
}
