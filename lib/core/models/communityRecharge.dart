import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityRecharge {
  final String id;
  final String company;
  final Timestamp createdAt;
  final String execCode;
  final String idRecharge;
  final int mount;
  final int state;

  CommunityRecharge(
      {this.id,
      this.company,
      this.createdAt,
      this.execCode,
      this.idRecharge,
      this.mount,
      this.state});

  factory CommunityRecharge.fromMap(Map data) {
    return CommunityRecharge(
      id: data['ID'] ?? '',
      company: data['Company'] ?? '',
      createdAt: data['CreatedAt'] ?? Timestamp.now(),
      execCode: data['ExecCode'] ?? '',
      idRecharge: data['IDRecharge'] ?? '',
      mount: data['Mount'] ?? 0,
      state: data['State'] ?? 1,
    );
  }

  factory CommunityRecharge.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return CommunityRecharge(
      id: doc.documentID,
      company: data['Company'] ?? '',
      createdAt: data['CreatedAt'] ?? Timestamp.now(),
      execCode: data['ExecCode'] ?? '',
      idRecharge: data['IDRecharge'] ?? '',
      mount: data['Mount'] ?? 0,
      state: data['State'] ?? 1,
    );
  }

  toJson() {
    return {
      "Company": company,
      "CreatedAt": createdAt,
      "ExecCode": execCode,
      "IDRecharge": idRecharge,
      "Mount": mount,
      "State": state,
    };
  }
}
