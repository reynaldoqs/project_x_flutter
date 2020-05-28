import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:urlix/core/models/communityRecharge.dart';
import 'package:urlix/ui/utilities/colors.dart' as xColors;

class RechargeTile extends StatelessWidget {
  const RechargeTile({Key key, this.cRecharge, this.onTap}) : super(key: key);
  final CommunityRecharge cRecharge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              mountBs(cRecharge.mount),
              SizedBox(
                width: 25,
              ),
              information(cRecharge.company, cRecharge.createdAt),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: xColors.black2,
                shape: BoxShape.circle,
              ),
              child: Icon(
                EvaIcons.plusOutline,
                color: xColors.textLight1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//importante things

Column information(String company, Timestamp createdAt) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Recarga $company',
        style: TextStyle(
          color: xColors.textLight1,
          fontSize: xColors.textSm,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: xColors.green1),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            'Hace ${createdAt.toDate().difference(DateTime.now()).inMinutes} minutos',
            style:
                TextStyle(fontSize: xColors.textXs, color: xColors.textLight3),
          )
        ],
      ),
    ],
  );
}

Container mountBs(int mount) {
  return Container(
    decoration: BoxDecoration(
      color: xColors.red1,
      shape: BoxShape.circle,
    ),
    height: 55,
    width: 55,
    child: Row(
      children: <Widget>[
        Text(
          mount.toString(),
          style: TextStyle(
            fontSize: mount > 9 ? 34 : 50,
            fontWeight: FontWeight.bold,
            height: 0.5,
            color: xColors.textLight1,
          ),
        ),
        Text(
          'bs',
          style: TextStyle(color: xColors.textLight1),
        ),
      ],
    ),
  );
}
