import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';

typedef InputBoxCallback = dynamic Function(String value);

class InputBoxWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final String? labelText;
  final InputBoxCallback? validationLogic;
  final bool numberKeyboard;
  final bool emptyValidation;
  final String? emptyValidationText;
  final String? requiredValidationText;
  final bool? autoValidation;
  final bool? isEnabled;
  final bool? emailKeyBoard;
  final TextEditingController? inputBoxController;
  final int? numberLength;

  const InputBoxWidget(
      {super.key,
      this.height,
      this.width,
      this.labelText,
      this.validationLogic,
      required this.numberKeyboard,
      this.emptyValidationText,
      required this.emptyValidation,
      this.requiredValidationText,
      this.isEnabled,
      this.autoValidation,
      this.emailKeyBoard,
      this.inputBoxController,
      this.numberLength});

  @override
  State<InputBoxWidget> createState() => _InputBoxWidgetState();
}

class _InputBoxWidgetState extends State<InputBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText!,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 12.sp),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            constraints: const BoxConstraints(minHeight: 30),
            width: widget.width!,
            // height: widget.height!,
            child: TextFormField(
                enabled: widget.isEnabled,
                onFieldSubmitted: widget.validationLogic,
                autovalidateMode: widget.autoValidation!
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                keyboardType: widget.emailKeyBoard!
                    ? TextInputType.emailAddress
                    : widget.numberKeyboard
                        ? const TextInputType.numberWithOptions(
                            decimal: true, signed: false)
                        : TextInputType.visiblePassword,
                inputFormatters: [
                  widget.numberKeyboard
                      ? LengthLimitingTextInputFormatter(widget.numberLength!)
                      : LengthLimitingTextInputFormatter(50),
                  widget.numberKeyboard
                      ? FilteringTextInputFormatter.deny(RegExp(r'[,\-\]]'))
                      : FilteringTextInputFormatter(RegExp(r'^[\u0020-\u007E]+$'),
                      allow: true)
                ],
                validator: (value) {
                  if (widget.emptyValidation) {
                    if (value!.isEmpty) {
                      return widget.emptyValidationText != null
                          ? "${widget.requiredValidationText} is required"
                          : "Field is required";
                    } else {
                      return widget.validationLogic!(value);
                    }
                  } else {
                    if (value!.isNotEmpty) {
                      return widget.validationLogic!(value);
                    }
                  }
                  return null;
                },
                controller: widget.inputBoxController,
                style: inputBoxTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: textColor,
                    overflow: TextOverflow.ellipsis),
                cursorColor: textColor,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: buttonColor),
                      borderRadius: BorderRadius.circular(5.0.r)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5.0.r)),
                  errorStyle: errorTextStyle,
                  filled: true,
                  fillColor: backgroundColor,
                  isDense: true,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: textColor),
                      borderRadius: BorderRadius.circular(5.0.r)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: textColor),
                      borderRadius: BorderRadius.circular(5.0.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(5.r)),
                ))),
      ],
    );
  }
}
