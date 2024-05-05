import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef InputBoxCallback = dynamic Function(String value);
typedef OnChanged = dynamic Function(String value);
typedef SuffixButtonFunction = dynamic Function();

class TextFormFieldWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final String? suffixText;
  final String? labelText;
  final InputBoxCallback? validationLogic;
  final OnChanged? onChanged;

  final SuffixButtonFunction? suffixButtonFunction;
  final TextEditingController? inputBoxController;
  final bool isPassword;
  final bool numberKeyboard;
  final bool emptyValidation;
  final String? emptyValidationText;
  final int? numberLimit;
  final bool? autoValidation;
  final bool? isEnabled;

  const TextFormFieldWidget({
    super.key,
    this.height,
    this.width,
    this.suffixText = "",
    this.labelText = "",
    this.validationLogic,
    this.onChanged,
    this.suffixButtonFunction,
    this.inputBoxController,
    this.numberLimit,
    this.isPassword = false,
    this.numberKeyboard = false,
    this.emptyValidation = false,
    this.emptyValidationText,
    this.autoValidation = true,
    this.isEnabled = true,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            controller: widget.inputBoxController,
            inputFormatters: [
              widget.numberKeyboard
                  ? LengthLimitingTextInputFormatter(widget.numberLimit)
                  : LengthLimitingTextInputFormatter(50),
            ],
            keyboardType: widget.numberKeyboard
                ? TextInputType.phone
                : TextInputType.visiblePassword,
            style: inputBoxTextStyle.copyWith(
                color: textColor, overflow: TextOverflow.ellipsis),
            cursorColor: textColor,
            cursorWidth: 1.0.sp,
            obscureText: widget.isPassword ? isPasswordVisible : false,
            enabled: widget.isEnabled! ? true : false,
            validator: (value) {
              if (widget.emptyValidation) {
                if (value!.isEmpty) {
                  return widget.emptyValidationText;
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
            decoration: InputDecoration(
                labelText: widget.labelText!,
                labelStyle: donationHistoryNameTextStyle,
                contentPadding: EdgeInsets.all(0.0),
                suffix: widget.isPassword
                    ? IconButton(
                        splashRadius: 1.0,
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility_rounded,
                        ),
                        onPressed: () => setState(
                            () => isPasswordVisible = !isPasswordVisible))
                    : null,
                focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor)),
                errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: errorTextColor)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor)),
                errorStyle: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: errorTextColor)),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
