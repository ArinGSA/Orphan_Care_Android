import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

class NotificationComponent extends StatelessWidget {
  final String? requestId;
  final String? date;
  final bool? isRequestAccepted;
  final Function? onTap;

  const NotificationComponent(
      {super.key,
      this.requestId,
      this.date,
      this.isRequestAccepted,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: 0.1.sh,
        width: 0.8.sw,
        padding: EdgeInsets.only(top: 10.r, bottom: 10.r, left: 20.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: buttonColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 0.8.sw,
              child: Column(
                children: [
                  textWidget("Request ID", requestId),
                  textWidget("Date", date)
                ],
              ),
            ),
            Text(
              isRequestAccepted!
                  ? "Your Request Has Been Accepted"
                  : "Your Request Has Been Rejected",
              style: GoogleFonts.inter(
                  fontSize: 15.sp, fontWeight: FontWeight.bold),
            )
          ],
        ),
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
