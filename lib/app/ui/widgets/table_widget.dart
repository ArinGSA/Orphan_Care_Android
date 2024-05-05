import 'package:flutter/material.dart';
import 'package:orphan_care/app/data/model/trust_models/trust_emergency_need_model.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef DeleteRecord = void Function(int index);

class TableWidget extends StatefulWidget {
  final List<TrustEmergencyNeedModel>? list;
  final DeleteRecord? deleteRecord;

  const TableWidget({super.key, this.list, this.deleteRecord});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<DataRow> dataRowList = [];
  List<DataColumn> dataColumnList = [
    DataColumn(
      label: Text(
        'S.no',
        style: appBarTextStyle,
      ),
    ),
    DataColumn(
      label: Text('Product', style: appBarTextStyle),
    ),
    DataColumn(
      label: Text('Quantity', style: appBarTextStyle),
    ),
    DataColumn(
      label: Text('Modify', style: appBarTextStyle),
    ),
  ];

  int? indexValue;

  @override
  Widget build(BuildContext context) {
    if (widget.list!.isNotEmpty) {
      dataRowList = [];
      for (int i = 0; i < widget.list!.length; i++) {
        dataRowList.add(dataRowWidget(i + 1, widget.list![i].productName,
            widget.list![i].unit, widget.list![i].quantity));
      }
    }
    return  Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: tableColor,
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: DataTable(
                columnSpacing: 25.w,
                horizontalMargin: 0,
                dataRowMinHeight: 10,
                dataRowMaxHeight: 50,
                columns: dataColumnList,
                rows: dataRowList),
          );
  }

  DataRow dataRowWidget(
      int? sNO, String? prodName, String? unit, int? quantity) {
    setState(() {});
    return DataRow(
      cells: [
        dataCellWidget(" ${sNO!.toString()})"),
        dataCellWidget(prodName!),
        dataCellWidget(quantity!.toString() + unit!),
        DataCell(IconButton(
          onPressed: () {
            setState(() {
              print(sNO);
              print("+++++++++++++");
              dataRowList.removeAt(sNO - 1);
              widget.deleteRecord!(sNO - 1);
            });
          },
          icon: Icon(Icons.remove_circle_outline),
        ))
      ],
    );
  }

  DataCell dataCellWidget(String textValue) {
    return DataCell(Text(textValue));
  }
}
