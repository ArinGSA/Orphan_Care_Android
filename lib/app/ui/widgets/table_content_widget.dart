import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

class TableContentWidget extends StatefulWidget {
  final String? sNo;
  final String? product;
  final String? unit;

  const TableContentWidget({super.key, this.sNo, this.product, this.unit});

  @override
  State<TableContentWidget> createState() => _TableContentWidgetState();
}

class _TableContentWidgetState extends State<TableContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
              decoration: BoxDecoration(
                  color: tableColor, borderRadius: BorderRadius.circular(5.r)),
              children: [
                textWidget(widget.sNo!),
                textWidget(
                  widget.product!,
                ),
                textWidget(
                  widget.unit!,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 24.sp,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                      size: 24.sp,
                    )),
              ])
        ]);
    Container(
      padding: EdgeInsets.all(10.r),
      height: 38.h,
      width: 370.w,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(5.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.sNo!,
            style: commonTextStyle,
          ),
          Text(
            widget.product!,
            style: commonTextStyle,
          ),
          Text(
            widget.unit!,
            style: commonTextStyle,
          ),
          Row(children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 24.sp,
                )),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.remove_circle_outline_rounded,
                  size: 24.sp,
                ))
          ])
        ],
      ),
    );
  }

  Widget textWidget(String textValue) {
    return Container(
      padding: EdgeInsets.only(left: 4.r),
      height: 38.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textValue,
            style: commonTextStyle,
          ),
        ],
      ),
    );
  }
}
