import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:urlix/core/models/communityRecharge.dart';
import 'package:urlix/core/providers/cRecharge.dart';
import 'package:urlix/ui/utilities/colors.dart' as xColors;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_service/models/sim_data.dart';
import 'package:sim_service/sim_service.dart';
import 'package:urlix/ui/widgets/rechargeTile.dart';
import 'package:ussd_service/ussd_service.dart';

class Recharges extends StatefulWidget {
  @override
  _RechargesState createState() => _RechargesState();
}

enum RequestState {
  Ongoing,
  Success,
  Error,
}

class _RechargesState extends State<Recharges> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final Firestore _fs = Firestore.instance;

  RequestState _requestState;
  //String _requestCode = "";
  String _responseCode = "";
  String _responseMessage = "";

  Future<void> _sendUssdRequest(String reqCode) async {
    print("We are going to do this $reqCode");
    setState(() {
      _requestState = RequestState.Ongoing;
    });
    try {
      String responseMessage;

      var hasAccessToCalls = await Permission.phone.request();
      if (hasAccessToCalls.isGranted) {
        SimData simData = await SimService.getSimData;

        if (simData == null) {
          debugPrint("simData cant be null");
          return;
        }

        print(simData.cards[1].subscriptionId);
        print(simData.activeSubscriptionInfoCount);

        responseMessage = await UssdService.makeRequest(3, reqCode);

        print("Respuesta");
        print(responseMessage);

        setState(() {
          _requestState = RequestState.Success;
          _responseMessage = responseMessage;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _requestState = RequestState.Error;
        _responseCode = e.code;
        _responseMessage = e.message;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      // called when the app has been closed completely and it's opened
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cRechargeProvider = Provider.of<CRechargeProvider>(context);

    return Scaffold(
      backgroundColor: xColors.black1,
      appBar: RechargeAppBar(),
      body: CRechargeList(
        crProvider: cRechargeProvider,
        onExecCode: (CommunityRecharge recharge) {
          print(recharge.execCode);
          _sendUssdRequest(recharge.execCode);
        },
      ),
    );
  }
}

class RechargeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RechargeAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: xColors.black1,
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: Icon(
              EvaIcons.moreHorizotnal,
              color: xColors.white1,
            ),
            onPressed: null)
      ],
      title: Text(
        "Recargas",
        style: TextStyle(
          color: xColors.white1,
          fontSize: xColors.textMd,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        child: Container(
          color: xColors.black2,
          height: 1,
        ),
        preferredSize: Size.fromHeight(1.0),
      ),
    );
  }
}

typedef ExecCodeCallBack = Function(CommunityRecharge recharge);

class CRechargeList extends StatelessWidget {
  const CRechargeList({Key key, this.onExecCode, this.crProvider})
      : super(key: key);
  final ExecCodeCallBack onExecCode;
  final CRechargeProvider crProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: crProvider.fetchCRechargesAsStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');

        if (snapshot.hasData) {
          var cRecharges = snapshot.data.documents
              .map((doc) => CommunityRecharge.fromFirestore(doc))
              .toList();

          return ListView.builder(
              itemCount: cRecharges.length,
              itemBuilder: (_, int index) {
                return RechargeTile(
                  cRecharge: cRecharges[index],
                  onTap: () {
                    print("to execute ${cRecharges[index].execCode}");
                    onExecCode(cRecharges[index]);
                  },
                );
              });
        } else {
          return Text(
            "Loading",
            style: TextStyle(color: xColors.white1),
          );
        }
      },
    );
  }
}
