import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/constants/constants.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';

class TrustDonationHistoryComponent extends StatelessWidget {
  final bool isAssetImage;
  final String bs64String;
  final String donorName;
  final String donateDate;
  final String amount;
  final String mobileNumber;

  const TrustDonationHistoryComponent(
      {super.key,
      required this.isAssetImage,
      required this.bs64String,
      required this.donorName,
      required this.donateDate,
      required this.amount,
      required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    Uint8List? decodedBytes;
    if (!isAssetImage) {
      decodedBytes = base64.decode(bs64String);
    }
    return Container(
      height: 0.14.sh,
      width: 0.9.sw,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          border: Border.all(color: buttonColor),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.2.sw,
            height: 0.1.sh,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: isAssetImage
                  ? const Image(
                      image: AssetImage(IconImages.donationProfileImage))
                  : Image.memory(decodedBytes!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 0.2.sh,
            width: 0.6.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      donorName,
                      style: TextStyle(fontSize: 13.sp),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      Constants.date,
                      donateDate,
                    ),
                    textWidget(
                      Constants.amount,
                      amount,
                    ),
                    textWidget(
                      Constants.contactNumber,
                      mobileNumber,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textWidget(String labelName, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelName,
          style: TextStyle(fontSize: 9.sp),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 9.sp),
        )
      ],
    );
  }
}
