import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:orphan_care/app/theme/app_colors.dart';

typedef RadioButtonCallBack = dynamic Function(String value);

class RadioButtonComponent extends StatefulWidget {
  final String labelText;
  final List<String> buttonValuesList;
  final bool needHorizontal;
  final String? initialValue;
  final RadioButtonCallBack validationLogic;
  final bool isEnabled;

  const RadioButtonComponent(
      {super.key,
      required this.labelText,
      required this.buttonValuesList,
      this.needHorizontal = false,
      required this.validationLogic,
      required this.isEnabled,
      this.initialValue});

  @override
  State<RadioButtonComponent> createState() => _RadioButtonComponentState();
}

class _RadioButtonComponentState extends State<RadioButtonComponent> {
  Map<String, bool> values = {};
  String? selectedGroup = "radio";
  bool isEnabledStepperButton = false;

  void setAnswers() {
    for (var item in widget.buttonValuesList) {
      values[item] = false;
      selectedGroup = widget.initialValue;
    }
  }

  @override
  void initState() {
    setAnswers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 12.sp),
        ),
        const SizedBox(
          height: 2,
        ),
        RadioGroup<String>.builder(
          direction: widget.needHorizontal ? Axis.horizontal : Axis.vertical,
          horizontalAlignment: MainAxisAlignment.start,
          activeColor: widget.isEnabled ? buttonColor : borderColor,
          groupValue: selectedGroup!,
          onChanged: (value) {
            widget.isEnabled
                ? setState(() {
                    if (value!.isNotEmpty) {
                      setState(() {
                        selectedGroup = value;
                        widget.validationLogic(value);
                      });
                    }
                  })
                : null;
          },
          textStyle: GoogleFonts.inter(fontSize: 10.sp, color: textColor),
          items: widget.buttonValuesList,
          itemBuilder: (item) => RadioButtonBuilder(
            item,
          ),
        ),
      ],
    );
  }
}
