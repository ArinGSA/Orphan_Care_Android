import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/text_form_field_widget.dart';

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({super.key});

  @override
  State<DonorProfileScreen> createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  DonorController donorController = Get.find<DonorController>();
  CommonController commonController = Get.find<CommonController>();
  final _formKey = GlobalKey<FormState>();
  var imageFile;
  bool profileUploaded = false;
  Uint8List? decodedBytes;

  final _nameController = TextEditingController();
  final _phNumController = TextEditingController();
  final _emailController = TextEditingController();

  setInitialValue() {
    _nameController.text = donorController.donorSignUPModel.donorName ?? "";
    _phNumController.text = donorController.donorSignUPModel.phoneNumber ?? "";
    _emailController.text = donorController.donorSignUPModel.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    setInitialValue();
    return Obx(() {
      if (donorController.donorSignUPModel.base64String != null) {
        decodedBytes =
            base64.decode(donorController.donorSignUPModel.base64String!);
      }
      setInitialValue();
      return Scaffold(
        appBar: CustomAppBar(
          title: Constants.profile,
          actionWidget: TextButton(
              onPressed: () => CommonFunctions.navigateScreen(
                  context, Routes.donorEditProfileScreen),
              child: Text(
                Constants.edit,
                style: labelTextStyle,
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
                            ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text("Profile"),
                SizedBox(
                  height: 0.1.sh,
                ),
                TextFormFieldWidget(
                    isEnabled: false,
                    labelText: Constants.name,
                    inputBoxController: _nameController,
                    emptyValidation: true,
                    emptyValidationText: Constants.trustNameValidationText,
                    validationLogic: (value) {}),
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
                    validationLogic: (value) {}),
              ],
            ),
          ),
        ),
      );
    });
  }
}
