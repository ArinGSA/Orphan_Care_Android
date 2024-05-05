import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_profile_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_dropdown.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';
import 'package:image_picker/image_picker.dart';

class TrustEditProfileScreen extends StatefulWidget {
  const TrustEditProfileScreen({super.key});

  @override
  State<TrustEditProfileScreen> createState() => _TrustEditProfileScreenState();
}

class _TrustEditProfileScreenState extends State<TrustEditProfileScreen> {
  TrustController trustController = Get.find<TrustController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  var imageFile;
  bool profileUploaded = false;
  Uint8List? decodedBytes;

  final _nameController = TextEditingController();
  final _phNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _careTakerNameController = TextEditingController();
  final _docCountController = TextEditingController();
  final _vehCountController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _accNUmController = TextEditingController();
  final _forController = TextEditingController();
  String? fors = "Child care";
  String? category = "Child Care Home";

  @override
  void initState() {
    setInitialValue();
    super.initState();
  }

  setInitialValue() {
    if (trustController.trustProfileModel.base64String != null) {
      decodedBytes =
          base64.decode(trustController.trustProfileModel.base64String!);
    }

    _nameController.text = trustController.trustProfileModel.trustName ?? "";
    _phNumController.text = trustController.trustProfileModel.phoneNumber ?? "";
    _forController.text = trustController.trustProfileModel.forWhom ?? "";
    category = trustController.trustProfileModel.category ?? category;
    _emailController.text = trustController.trustProfileModel.email ?? "";
    _careTakerNameController.text =
        trustController.trustProfileModel.careTakerName ?? "";
    _docCountController.text =
        trustController.trustProfileModel.doctorCount ?? "";
    _vehCountController.text =
        trustController.trustProfileModel.vehicleCount ?? "";
    _address1Controller.text = trustController.trustProfileModel.address1 ?? "";
    _cityController.text = trustController.trustProfileModel.city ?? "";
    _pinCodeController.text = trustController.trustProfileModel.pinCode ?? "";
    _accNUmController.text =
        trustController.trustProfileModel.accountNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Constants.editProfile,
        actionWidget: trustController.trustUpdateLoading
            ? const CircularProgressIndicator()
            : TextButton(
                onPressed: () {
                  saveProfileData();
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
        padding: EdgeInsets.all(10.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: profileUploaded
                    ? Container(
                        width: double.infinity,
                        height: 0.2.sh,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                                image: FileImage(imageFile), fit: BoxFit.fill)),
                      )
                    : trustController.trustProfileModel.base64String != null
                        ? Container(
                            width: double.infinity,
                            height: 0.2.sh,
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
                                image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(IconImages.trustProfile)),
                                border:
                                    Border.all(color: profileBackgroundColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.r))),
                            child: GestureDetector(
                              onTap: () => showProfileUploadOption(context),
                            ),
                          ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Profile"),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.trustName,
                  inputBoxController: _nameController,
                  emptyValidation: true,
                  emptyValidationText: Constants.trustNameValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.trustName = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: false,
                  labelText: Constants.phNumber,
                  inputBoxController: _phNumController,
                  numberKeyboard: true,
                  numberLimit: 10,
                  emptyValidation: true,
                  emptyValidationText: Constants.phNumberEmptyValidationText,
                  validationLogic: (value) {}),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.email,
                  inputBoxController: _emailController,
                  emptyValidation: true,
                  emptyValidationText: Constants.emailEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.email = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.careTaker,
                  inputBoxController: _careTakerNameController,
                  emptyValidation: true,
                  emptyValidationText: Constants.careTakerEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.careTakerName = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.fors,
                  inputBoxController: _forController,
                  emptyValidation: true,
                  emptyValidationText: "This field can not be empty",
                  validationLogic: (value) {
                    trustController.trustProfileModel.forWhom = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomDropDown(
                isEnabled: true,
                labelText: Constants.category,
                currentItem: category,
                width: 350.w,
                height: 45.h,
                emptyValidation: true,
                chosenValue: (value) {
                  category = value;
                  trustController.trustProfileModel.category = value;
                },
                requiredValidationText: "Category",
                dropDownItems: Constants.categoryDropDownList,
                emptyValidationText: "select a category",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.doctorCount,
                  inputBoxController: _docCountController,
                  numberKeyboard: true,
                  numberLimit: 2,
                  emptyValidation: true,
                  emptyValidationText: Constants.doctorCountEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.doctorCount = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.vehicleCount,
                  inputBoxController: _vehCountController,
                  numberLimit: 2,
                  numberKeyboard: true,
                  emptyValidation: true,
                  emptyValidationText:
                      Constants.vehicleCountEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.vehicleCount = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.address1,
                  inputBoxController: _address1Controller,
                  emptyValidation: true,
                  emptyValidationText: Constants.address1EmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.address1 = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.cityName,
                  inputBoxController: _cityController,
                  emptyValidation: true,
                  emptyValidationText: Constants.cityNameEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.city = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.pinCode,
                  inputBoxController: _pinCodeController,
                  numberKeyboard: true,
                  numberLimit: 6,
                  emptyValidation: true,
                  emptyValidationText: Constants.pinCodeEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.pinCode = value;
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  isEnabled: true,
                  labelText: Constants.accountNumber,
                  inputBoxController: _accNUmController,
                  numberLimit: 15,
                  numberKeyboard: true,
                  emptyValidation: true,
                  emptyValidationText:
                      Constants.accountNumberEmptyValidationText,
                  validationLogic: (value) {
                    trustController.trustProfileModel.accountNumber = value;
                  }),
            ],
          ),
        ),
      ),
    );
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

  saveProfileData() async {
    String? bs64;
    if (imageFile != null) {
      String bs64 = await CommonFunctions.convertBase64String(imageFile.path);
      trustController.trustProfileModel.base64String = bs64;
      print(bs64);
      print("++++++++++++++");
    }

    if (_formKey.currentState!.validate()) {
      var trustProfileData = TrustProfileModel(
        base64String: trustController.trustProfileModel.base64String,
        address1: trustController.trustProfileModel.address1,
        city: trustController.trustProfileModel.city,
        pinCode: trustController.trustProfileModel.pinCode,
        forWhom: trustController.trustProfileModel.forWhom ?? fors,
        trustName: trustController.trustProfileModel.trustName,
        category: trustController.trustProfileModel.category ?? category,
        phoneNumber: trustController.trustProfileModel.phoneNumber,
        careTakerName: trustController.trustProfileModel.careTakerName,
        doctorCount: trustController.trustProfileModel.doctorCount,
        vehicleCount: trustController.trustProfileModel.vehicleCount,
        email: trustController.trustProfileModel.email,
        accountNumber: trustController.trustProfileModel.accountNumber,
        confirmPassword: trustController.trustProfileModel.confirmPassword,
        password: trustController.trustProfileModel.password,
      );
      try {
        trustController.trustUpdateLoading = true;
        await commonController.putDataBaseByKey(
            trustProfileData,
            Constants.orphanDataBase,
            "${_phNumController.text}${Constants.trustProfileDataKey}");

        trustController.trustProfileModel = await commonController.getDataBaseByKey(
            Constants.orphanDataBase,
            "${trustController.trustProfileModel.phoneNumber}${Constants.trustProfileDataKey}");

        trustController.trustUpdateLoading = false;
        await CommonFunctions.customToast(
            Constants.profileUpdateSuccessMessage);
        Get.back();
      } catch (err) {
        trustController.trustUpdateLoading = false;
        print(err.toString());
        CommonFunctions.customToast(Constants.errorMessage);
        return err;
      }
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
