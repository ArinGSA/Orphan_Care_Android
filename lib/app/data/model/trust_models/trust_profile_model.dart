import 'package:hive/hive.dart';

part 'trust_profile_model.g.dart';

@HiveType(typeId: 2)
class TrustProfileModel {
  @HiveField(0)
  String? trustName;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? careTakerName;
  @HiveField(4)
  String? forWhom;
  @HiveField(5)
  String? category;
  @HiveField(6)
  String? doctorCount;
  @HiveField(7)
  String? vehicleCount;
  @HiveField(8)
  String? address1;
  @HiveField(9)
  String? city;
  @HiveField(10)
  String? pinCode;
  @HiveField(11)
  String? accountNumber;
  @HiveField(12)
  String? base64String;
  @HiveField(13)
  String? password;
  @HiveField(14)
  String? confirmPassword;

  TrustProfileModel(
      {this.trustName,
      this.phoneNumber,
      this.email,
      this.careTakerName,
      this.forWhom,
      this.category,
      this.doctorCount,
      this.vehicleCount,
      this.address1,
      this.city,
      this.pinCode,
      this.accountNumber,
      this.base64String,
      this.password,
      this.confirmPassword});
}
