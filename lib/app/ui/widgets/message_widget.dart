import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';

class MessageWidget extends StatefulWidget {
  final bool? isFeedback;
  final bool? isPaymentSuccess;
  final bool? isPayment;
  final bool? isAdoptRequestDeclined;
  final bool? isAdoptRequestAccepted;
  final bool? isAdoptSubmitted;

  const MessageWidget(
      {super.key,
      this.isFeedback,
      this.isPayment,
      this.isPaymentSuccess,
      this.isAdoptRequestDeclined,
      this.isAdoptRequestAccepted,
      this.isAdoptSubmitted});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () => Get.back());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      top: false,
      child: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 0.25.sh,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [appBarTopColor, Colors.white],
                  // You can change these colors
                  stops: [0.0, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                widget.isPayment!
                    ? !widget.isPaymentSuccess!
                        ? Text(
                            "Payment Incomplete",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp,
                            ),
                          )
                        : Text(
                            " Payment Completed",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp,
                            ),
                          )
                    : const SizedBox(),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: widget.isAdoptSubmitted!
                        ? Image.asset(IconImages.adoptSubmitImage)
                        : widget.isFeedback! ||
                                widget.isPaymentSuccess! ||
                                widget.isAdoptRequestAccepted!
                            ? Image.asset(IconImages.successTickIcon)
                            : Image.asset(IconImages.failureIcon)),
                const SizedBox(height: 5),
                Text(
                  widget.isAdoptSubmitted!
                      ? "Contact you Shortly"
                      : widget.isPayment!
                          ? widget.isPaymentSuccess!
                              ? "Thanks"
                              : "Sorry"
                          : widget.isFeedback!
                              ? "Thanks"
                              : widget.isAdoptRequestAccepted!
                                  ? "Request Approved"
                                  : "Request Declined",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                )
              ],
            ),
            Container(
              height: 0.25.sh,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, appBarTopColor],
                  // You can change these colors
                  stops: [0.1, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
