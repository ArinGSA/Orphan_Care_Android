import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

class TableHeadWidget extends StatelessWidget {
  const TableHeadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(

        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(5.r)),
              children: [
                textWidget("S.no"),
                textWidget("Product"),
                textWidget("Unit"),
                textWidget("Quantity")
              ])
        ]);
  }

  Widget textWidget(String textValue) {
    return Container(
      padding: EdgeInsets.only(left: 3.r),
      height: 38.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textValue,
            style: appBarTextStyle,
          ),
        ],
      ),
    );
  }
}
