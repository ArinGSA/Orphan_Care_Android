import 'package:flutter/material.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

class DonorDonationHistoryComponent extends StatelessWidget {
  final String? trustName;
  final String? date;
  final String? donation;
  final String? location;

  const DonorDonationHistoryComponent(
      {super.key, this.trustName, this.date, this.donation, this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 0.8.sw,
      padding:
          EdgeInsets.only(top: 10.r, bottom: 15.r, left: 30.r, right: 30.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: buttonColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 0.8.sw,
            child: Text(
              trustName!,
              style: commonTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                textWidget("Date", date!),
                textWidget("Donation", donation!),
                textWidget("Location", location!)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textWidget(String? textValue, String? valueText) {
    return Row(
      children: [
        Text(
          textValue!,
          style: donationTextStyle,
          overflow: TextOverflow.fade,
        ),
        Text(
          " : ",
          style: donationTextStyle,
          overflow: TextOverflow.fade,
        ),
        SizedBox(
          width: 100.w,
          child: Text(
            valueText!,
            style: donationTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
