import 'package:hive/hive.dart';

part 'donor_signup_model.g.dart';

@HiveType(typeId: 9)
class DonorSignUPModel {
  @HiveField(0)
  String? donorName;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? password;
  @HiveField(4)
  String? confirmPassword;
  @HiveField(5)
  String? base64String;

  DonorSignUPModel(
      {this.donorName,
      this.phoneNumber,
      this.email,
      this.password,
      this.confirmPassword,
      this.base64String});
}
