import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:urlix/core/models/communityRecharge.dart';
import 'package:urlix/core/services/firestoreApi.dart';
import 'package:urlix/locator.dart';

class CRechargeProvider extends ChangeNotifier {
  FirestoreApi _api = locator<FirestoreApi>();

  List<CommunityRecharge> recharges;

  Future<List<CommunityRecharge>> fetchRecharges() async {
    var result = await _api.getDataCollection();
    recharges = result.documents
        .map((doc) => CommunityRecharge.fromFirestore(doc))
        .toList();
    return recharges;
  }

  Stream<QuerySnapshot> fetchCRechargesAsStream() {
    return _api.streamDataCollection();
  }

  Future<CommunityRecharge> getCRechargeById(String id) async {
    var doc = await _api.getDocumentById(id);
    return CommunityRecharge.fromFirestore(doc);
  }

  Future<void> removeCRecharge(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future<void> updateCRecharge(CommunityRecharge cRecharge, id) async {
    await _api.updateDocument(cRecharge.toJson(), id);
    return;
  }
}
