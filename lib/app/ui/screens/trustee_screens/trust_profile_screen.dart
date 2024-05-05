import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_dropdown.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';
import 'package:image_picker/image_picker.dart';

class TrustProfileScreen extends StatefulWidget {
  const TrustProfileScreen({super.key});

  @override
  State<TrustProfileScreen> createState() => _TrustProfileScreenState();
}

class _TrustProfileScreenState extends State<TrustProfileScreen> {
  TrustController trustController = Get.find<TrustController>();

  final _formKey = GlobalKey<FormState>();

  var imageFile;
  bool profileUploaded = false;
  Uint8List? decodedBytes;

  final _nameController = TextEditingController();
  final _phNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _careTakerNameController = TextEditingController();
  final _forController = TextEditingController();
  final _docCountController = TextEditingController();
  final _vehCountController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _accNUmController = TextEditingController();

  String? category = "Child Care Home";

  setInitialValue() {
    _nameController.text = trustController.trustProfileModel.trustName ?? "";
    _forController.text = trustController.trustProfileModel.forWhom ?? "";
    category = trustController.trustProfileModel.category ?? category;
    _phNumController.text = trustController.trustProfileModel.phoneNumber ?? "";
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
    return Obx(() {
      if (trustController.trustProfileModel.base64String != null) {
        decodedBytes =
            base64.decode(trustController.trustProfileModel.base64String!);
      }
      setInitialValue();
      return Scaffold(
        appBar: CustomAppBar(
          title: Constants.profile,
          actionWidget: TextButton(
              onPressed: () => CommonFunctions.navigateScreen(
                  context, Routes.trustEditProfileScreen),
              child: Text(
                Constants.edit,
                style: labelTextStyle,
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
                                  image: FileImage(imageFile),
                                  fit: BoxFit.fill)),
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
                            )
                          : Container(
                              height: 0.15.sh,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage(IconImages.trustProfile)),
                                  border:
                                      Border.all(color: profileBackgroundColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.r))),
                            ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Profile"),
                TextFormFieldWidget(
                    isEnabled: false,
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
                    isEnabled: false,
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
                    isEnabled: false,
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
                    isEnabled: false,
                    labelText: Constants.fors,
                    inputBoxController: _forController,
                    emptyValidation: true,
                    emptyValidationText: "This field can not be empty",
                    validationLogic: (value) {
                      trustController.trustProfileModel.forWhom = value;
                    }),
                /*CustomDropDown(
                  isEnabled: false,
                  labelText: Constants.fors,
                  currentItem: fors,
                  width: 350.w,
                  height: 45.h,
                  chosenValue: (value) {
                    fors = value;
                    trustController.trustProfileModel.forWhom = value;
                  },
                  dropDownItems: Constants.forDropDownList,
                  emptyValidation: false,
                ),*/
                const SizedBox(
                  height: 10,
                ),
                CustomDropDown(
                  isEnabled: false,
                  labelText: Constants.category,
                  currentItem: category,
                  width: 350.w,
                  height: 45.h,
                  chosenValue: (value) {
                    category = value;
                    trustController.trustProfileModel.category = value;
                  },
                  dropDownItems: Constants.categoryDropDownList,
                  emptyValidation: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWidget(
                    isEnabled: false,
                    labelText: Constants.doctorCount,
                    inputBoxController: _docCountController,
                    numberKeyboard: true,
                    numberLimit: 2,
                    emptyValidation: true,
                    emptyValidationText:
                        Constants.doctorCountEmptyValidationText,
                    validationLogic: (value) {
                      trustController.trustProfileModel.doctorCount = value;
                    }),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWidget(
                    isEnabled: false,
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
                    isEnabled: false,
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
                    isEnabled: false,
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
                    isEnabled: false,
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
                    isEnabled: false,
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
    });
  }
}
