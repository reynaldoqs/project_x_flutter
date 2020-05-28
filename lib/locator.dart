import 'package:get_it/get_it.dart';
import 'package:urlix/core/services/firestoreApi.dart';
import 'package:urlix/core/providers/cRecharge.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreApi('communityRecharge'));
  locator.registerLazySingleton(() => CRechargeProvider());
}
