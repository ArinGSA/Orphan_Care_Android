import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/constants/common%20_functions.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/theme/icon_images.dart';


class CommonTrustComponent extends StatelessWidget {
  final bool? isAssetImage;
  final String? assetImagePath;
  final String bs64String;
  final String trustName;
  final String category;
  final String forWhom;
  final String phNumber;
  final Function onTap;

  const CommonTrustComponent(
      {super.key,
      this.isAssetImage = false,
      this.assetImagePath,
      required this.bs64String,
      required this.trustName,
      required this.category,
      required this.forWhom,
      required this.phNumber,
      required this.onTap});

  @override
  Widget build(BuildContext context) {


    Uint8List? decodedBytes;
    if (!isAssetImage!) {
      decodedBytes = base64.decode(bs64String);
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 90.h,
        width: double.infinity.w,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: buttonColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 130.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: isAssetImage!
                    ? Image.asset(IconImages.trustProfile)
                    : Image.memory(decodedBytes!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 180.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name", style: donationHistoryDateTextStyle),
                      Text("Category", style: donationHistoryDateTextStyle),
                      Text("For", style: donationHistoryDateTextStyle),
                      Text("Phone No", style: donationHistoryDateTextStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("-", style: donationHistoryDateTextStyle),
                      Text("-", style: donationHistoryDateTextStyle),
                      Text("-", style: donationHistoryDateTextStyle),
                      Text("-", style: donationHistoryDateTextStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 100.w,
                          child: Text(trustName,
                              style: donationHistoryDateTextStyle,
                              overflow: TextOverflow.ellipsis)),
                      SizedBox(
                          width: 100.w,
                          child: Text(category,
                              overflow: TextOverflow.ellipsis,
                              style: donationHistoryDateTextStyle)),
                      SizedBox(
                          width: 100.w,
                          child: Text(forWhom,
                              overflow: TextOverflow.ellipsis,
                              style: donationHistoryDateTextStyle)),
                      SizedBox(
                          width: 100.w,
                          child: Text(CommonFunctions.formatPhoneNumber(phNumber),
                              overflow: TextOverflow.ellipsis,
                              style: donationHistoryDateTextStyle)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
