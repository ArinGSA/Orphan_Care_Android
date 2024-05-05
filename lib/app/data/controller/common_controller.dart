import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_donation_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_notification_model.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_adopt_request_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_donation_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_emergency_need_model.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:path_provider/path_provider.dart';

class CommonController extends GetxController {
  final _isEnabled = false.obs;

  bool get isEnabled => _isEnabled.value;

  set isEnabled(bool value) => _isEnabled.value = value;

  Future initializeHive() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter<DonorDonationList>(DonorDonationListAdapter());
    Hive.registerAdapter<DonorNotificationList>(DonorNotificationListAdapter());
    Hive.registerAdapter<DonorNotificationModel>(
        DonorNotificationModelAdapter());
    Hive.registerAdapter<DonorDonationModel>(DonorDonationModelAdapter());
    Hive.registerAdapter<DonorSignUPModel>(DonorSignUPModelAdapter());
    Hive.registerAdapter<AdoptRequestList>(AdoptRequestListAdapter());
    Hive.registerAdapter<EmergencyList>(EmergencyListAdapter());
    Hive.registerAdapter<TrustProfileModel>(TrustProfileModelAdapter());
    Hive.registerAdapter<TrustEmergencyNeedModel>(
        TrustEmergencyNeedModelAdapter());
    Hive.registerAdapter<TrustDonationModel>(TrustDonationModelAdapter());
    Hive.registerAdapter<TrustAdoptRequestModel>(
        TrustAdoptRequestModelAdapter());
    await openDataBase(Constants.orphanDataBase);
  }

  Future openDataBase(String dataBaseName) async =>
      await Hive.openBox(dataBaseName);

  Future<void> addDataToDataBase(var data, String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.add(data);
  }

  Future<void> putDataBaseByKey(
      var data, String dataBaseName, String keyValue) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.put(keyValue, data);
  }

  dynamic getDataBaseByKey(String dataBaseName, String keyValue) {
    dynamic value;
    var dataBase = Hive.box(dataBaseName);
    try {
      if (dataBase.containsKey(keyValue)) {
        value = dataBase.get(keyValue);
      } else {
        return;
      }
    } catch (err) {
      print(err);
    }

    return value;
  }

  bool checkKeyContainsInDataBase(String dataBaseName, String keyValue) {
    var dataBase = Hive.box(dataBaseName);
    print(dataBase.containsKey(keyValue));
    return dataBase.containsKey(keyValue);
  }

  Future<void> putAtDataBaseIndex(
      var data, String dataBaseName, int index) async {
    var dataBase = Hive.box(dataBaseName);

    await dataBase.putAt(0, data);
  }

  Future<void> deleteValueDataBaseIndexByKey(
      String dataBaseName, String keyValue) async {
    var dataBase = Hive.box(dataBaseName);

    await dataBase.delete(keyValue);
  }

  Future<void> closeDataBase(String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.close();
  }

  Future<void> clearDataBase(String dataBaseName) async {
    var dataBase = Hive.box(dataBaseName);
    await dataBase.clear();
  }
}
