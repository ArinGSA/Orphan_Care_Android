import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';

class PaymentWidget extends StatelessWidget {
  final String? iconPath;
  final String? paymentType;
  final Function? onTap;

  const PaymentWidget({super.key, this.onTap, this.iconPath, this.paymentType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: 0.07.sh,
        width: 0.8.sw,
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: buttonColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 0.4.sw,
              child: Row(
                children: [
                  Image.asset(
                    iconPath!,
                    height: 0.05.sh,
                    width: 0.05.sw,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    paymentType!,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}
