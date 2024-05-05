import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/model/donor_models/donor_signup_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';

class DonorEditProfileScreen extends StatefulWidget {
  const DonorEditProfileScreen({super.key});

  @override
  State<DonorEditProfileScreen> createState() => _DonorEditProfileScreenState();
}

class _DonorEditProfileScreenState extends State<DonorEditProfileScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  var imageFile;
  bool profileUploaded = false;
  final picker = ImagePicker();
  Uint8List? decodedBytes;
  final _nameController = TextEditingController();
  final _phNumController = TextEditingController();
  final _emailController = TextEditingController();

  setInitialValue() {
    if (donorController.donorSignUPModel.base64String != null) {
      decodedBytes =
          base64.decode(donorController.donorSignUPModel.base64String!);
    }
    _nameController.text = donorController.donorSignUPModel.donorName ?? "";
    _phNumController.text = donorController.donorSignUPModel.phoneNumber ?? "";
    _emailController.text = donorController.donorSignUPModel.email ?? "";
  }

  @override
  void initState() {
    setInitialValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: Constants.editProfile,
          actionWidget: donorController.donorSignUpLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () async {
                    await saveProfileData();
                  },
                  child: Text(
                    Constants.save,
                    style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: editButtonTextColor),
                  )),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 50.r, right: 50.r, bottom: 50.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: profileUploaded
                      ? Container(
                          height: 0.15.sh,
                          width: 0.3.sw,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.fill)),
                        )
                      : donorController.donorSignUPModel.base64String != null
                          ? Container(
                              height: 0.15.sh,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: MemoryImage(decodedBytes!)),
                              ),
                              child: GestureDetector(
                                onTap: () => showProfileUploadOption(context),
                              ),
                            )
                          : Container(
                              height: 0.15.sh,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 15.0,
                                        offset: Offset(0.0, 0.75))
                                  ],
                                  color: backgroundColor,
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IconImages.donorProfileImage)),
                                  border: Border.all(color: textColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                              child: GestureDetector(
                                onTap: () => showProfileUploadOption(context),
                              ),
                            ),
                ),
                const SizedBox(height: 10),
                const Text("Profile"),
                SizedBox(height: 0.1.sh),
                TextFormFieldWidget(
                    isEnabled: true,
                    labelText: Constants.name,
                    inputBoxController: _nameController,
                    emptyValidation: true,
                    emptyValidationText: Constants.userNameValidationText,
                    validationLogic: (value) {
                      donorController.donorSignUPModel.donorName = value;
                    }),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                    isEnabled: false,
                    labelText: Constants.phNumber,
                    inputBoxController: _phNumController,
                    numberKeyboard: true,
                    numberLimit: 10,
                    emptyValidation: true,
                    emptyValidationText: Constants.phNumberEmptyValidationText,
                    validationLogic: (value) {
                      donorController.donorSignUPModel.phoneNumber = value;
                    }),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                    isEnabled: true,
                    labelText: Constants.email,
                    inputBoxController: _emailController,
                    emptyValidation: true,
                    emptyValidationText: Constants.emailEmptyValidationText,
                    validationLogic: (value) {
                      donorController.donorSignUPModel.email = value;
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }

  saveProfileData() async {
    String? bs64;
    if (imageFile != null) {
      String bs64 = await CommonFunctions.convertBase64String(imageFile.path);
      donorController.donorSignUPModel.base64String = bs64;
      print(bs64);
      print("++++++++++++++");
    }

    if (_formKey.currentState!.validate()) {
      var donorProfileData = DonorSignUPModel(
        donorName: donorController.donorSignUPModel.donorName,
        phoneNumber: donorController.donorSignUPModel.phoneNumber,
        base64String: donorController.donorSignUPModel.base64String,
        email: donorController.donorSignUPModel.email,
        confirmPassword: donorController.donorSignUPModel.confirmPassword,
        password: donorController.donorSignUPModel.password,
      );
      try {
        donorController.donorSignUpLoading = true;
        await commonController.putDataBaseByKey(
            donorProfileData,
            Constants.orphanDataBase,
            "${_phNumController.text}${Constants.donorProfileDataKey}");
        print(
            "${donorController.donorSignUPModel.phoneNumber}${Constants.donorProfileDataKey}");
        donorController.donorSignUPModel = await commonController.getDataBaseByKey(
            Constants.orphanDataBase,
            "${donorController.donorSignUPModel.phoneNumber}${Constants.donorProfileDataKey}");

        donorController.donorSignUpLoading = false;
        await CommonFunctions.customToast(
            Constants.profileUpdateSuccessMessage);
        Get.back();
      } catch (err) {
        donorController.donorSignUpLoading = false;
        print(err.toString());
        CommonFunctions.customToast(Constants.errorMessage);
        return err;
      }
    }
  }

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );
    imageFile = pickedFile != null
        ? File(
            pickedFile.path,
          )
        : null;
    if (imageFile != null) {
      setState(() {
        profileUploaded = true;
        // state = AppState.picked;
      });
    }
  }

  void showProfileUploadOption(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              color: appBarTopColor,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text(Constants.photoLibrary),
                      onTap: () {
                        chooseImage(ImageSource.gallery);

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text(Constants.camera),
                    onTap: () {
                      chooseImage(ImageSource.camera);

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
